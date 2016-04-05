RELEASE=$(shell git describe --tags)

jenkins-client-service-${VERSION}.spec : jenkins-client-service.spec
	sed -e "s#VERSION#${VERSION}#" -e "s#RELEASE#${RELEASE}#" -e "w${@}" ${<}

jenkins-client-service-${VERSION} :
	mkdir ${@}
	git -C ${@} init
	git -C ${@} remote add origin git@github.com:desertedscorpion/lostlocomotive.git
	git -C ${@} fetch origin

jenkins-client-service-${VERSION}.tar : jenkins-client-service-${VERSION}
	git -C ${<} archive --prefix jenkins-client-service-${VERSION}/ tags/${VERSION} > ${@}

jenkins-client-service-${VERSION}.tar.gz : jenkins-client-service-${VERSION}.tar
	gzip --to-stdout ${<} > ${@}

buildsrpm/jenkins-client-service-${VERSION}-${RELEASE}.src.rpm : jenkins-client-service-${VERSION}.spec jenkins-client-service-${VERSION}.tar.gz
	mkdir --parents buildsrpm
	mock --buildsrpm --spec jenkins-client-service-${VERSION}.spec --sources jenkins-client-service-${VERSION}.tar.gz --resultdir buildsrpm

rebuild/jenkins-client-service-${VERSION}-${RELEASE}.x86_64.rpm : buildsrpm/jenkins-client-service-${VERSION}-${RELEASE}.src.rpm
	mkdir --parents rebuild
	mock --rebuild buildsrpm/jenkins-client-service-${VERSION}-${RELEASE}.src.rpm --resultdir rebuild
