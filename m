From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 12:25:29 -0800
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <1478459581-22654-3-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-3-git-send-email-sagi@grimberg.me>
Message-ID: <1478550329.5463.7.camel@linux.intel.com>

On Sun, 2016-11-06@21:13 +0200, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> ?nvme.spec.in | 14 ++++++++++++++
> ?1 file changed, 14 insertions(+)
> 
> diff --git a/nvme.spec.in b/nvme.spec.in
> index a4718773a962..e95810995395 100644
> --- a/nvme.spec.in
> +++ b/nvme.spec.in
> @@ -33,6 +33,20 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
> ?%clean
> ?rm -rf $RPM_BUILD_ROOT
> ?
> +%post
> +if [ $1 = 1 ]; then # 1 : This package is being installed for the
> first time
> +	if [ ! -f /etc/nvme/hostnqn ]; then
> +		install -D /dev/null /etc/nvme/hostnqn
> +		year_month=$(date | awk '{print $6"-"$3}')

Hey Sagi,

7.9 of the base NVMe spec makes it clear on unique names that the "2nd
format", which is what is being assembled here, uses a fixed date
"2014-08" in it's name, which is exactly what the NVMe Host driver does
as its default:

fabrics.c: ?"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUb", &host->id);

I would just do what the NVMe host is doing already and make it easier
on yourself ;-).
