From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 08 Nov 2016 09:41:37 -0800
Subject: [PATCH nvme-cli v1 2/2] nvme.spec/debian: Auto generate host
 nqn as part of install
In-Reply-To: <1478602108-29571-3-git-send-email-sagi@grimberg.me>
References: <1478602108-29571-1-git-send-email-sagi@grimberg.me>
 <1478602108-29571-3-git-send-email-sagi@grimberg.me>
Message-ID: <1478626897.9959.21.camel@linux.intel.com>

On Tue, 2016-11-08@12:48 +0200, Sagi Grimberg wrote:
> The installation will generate a hostnqn and store it in
> /etc/nvme/hostnqn file (in case it doesn't exist).
> This file will be removed upon uninstallation (purge on for debian).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> ?debian/postinst | 20 ++++++++++++++++++++
> ?debian/postrm???|??5 +++++
> ?nvme.spec.in????| 12 ++++++++++++
> ?3 files changed, 37 insertions(+)
> ?create mode 100644 debian/postinst
> ?create mode 100644 debian/postrm
> 
> diff --git a/debian/postinst b/debian/postinst
> new file mode 100644
> index 000000000000..b258cf569c3e
> --- /dev/null
> +++ b/debian/postinst
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +set -e
> +
> +case "$1" in
> +????configure|install)
> +	if [ ! -f /etc/nvme/hostnqn ]; then
> +		install -D /dev/null /etc/nvme/hostnqn

Would it just be easier to do "mkdir -p /etc/nvme/hostnqn"? ?

> +		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
> +????????fi
> +????????;;
> +
> +????upgrade|abort-upgrade)
> +????????;;
> +????*)
> +????????echo "postinst called with unknown argument \`$1'" >&2
> +????????exit 0
> +????????;;
> +esac
> +exit 0
> diff --git a/debian/postrm b/debian/postrm
> new file mode 100644
> index 000000000000..d678fc8a90ac
> --- /dev/null
> +++ b/debian/postrm
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +if [ "$1" = "purge" ]; then
> +????rm -rf /etc/nvme
> +fi
> diff --git a/nvme.spec.in b/nvme.spec.in
> index a4718773a962..8bda97d819ba 100644
> --- a/nvme.spec.in
> +++ b/nvme.spec.in
> @@ -33,6 +33,18 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
> ?%clean
> ?rm -rf $RPM_BUILD_ROOT
> ?
> +%post
> +if [ $1 = 1 ]; then # 1 : This package is being installed for the
> first time
> +	if [ ! -f /etc/nvme/hostnqn ]; then
> +		install -D /dev/null /etc/nvme/hostnqn
> +		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
> +????????fi
> +fi
> +
> +%preun
> +if [ "$1" = "remove" ]; then
> +????rm -rf /etc/nvme

This could remove a 'discovery.conf' file that is also located in
/etc/nvme, which would be bad. ?Let's just remove the file
/ete/nvme/hostnqn that this will generate.
