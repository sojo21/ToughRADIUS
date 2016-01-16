systemctl disable firewalld.service

systemctl stop firewalld.service

mkdir -p /opt/toughradius/data
mkdir -p /var/toughradius

cp /opt/toughradius/docker/privkey.pem /var/toughradius/privkey.pem
cp /opt/toughradius/docker/cacert.pem /var/toughradius/cacert.pem

cp /opt/toughradius/docker/radiusd.conf /etc/radiusd.conf
cp /opt/toughradius/docker/supervisord.conf /etc/supervisord.conf
cp /opt/toughradius/docker/toughrad /usr/bin/toughrad
cp /opt/toughradius/docker/toughradius.service /usr/lib/systemd/system/toughradius.service

chmod +x /usr/bin/toughrad

yum update -y
yum install -y libffi-devel openssl openssl-devel git gcc crontabs python-devel python-setuptools
yum install -y  mysql-devel MySQL-python
yum clean all

easy_install pip
pip install supervisor
pip install Mako==0.9.0
pip install Beaker==1.6.4
pip install MarkupSafe==0.18
pip install PyYAML==3.10
pip install SQLAlchemy==0.9.8
pip install Twisted==14.0.2
pip install autobahn==0.9.3-3
pip install bottle==0.12.7
pip install six==1.8.0
pip install tablib==0.10.0
pip install zope.interface==4.1.1
pip install pycrypto==2.6.1
pip install pyOpenSSL>=0.14
pip install service_identity

ln -s /opt/toughradius/toughctl /usr/bin/toughctl && chmod +x /usr/bin/toughctl
/opt/toughradius/toughctl --initdb

service toughradius start

systemctl enable toughradius
