From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 7 Nov 2016 09:36:39 +0100
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <1478459581-22654-3-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-3-git-send-email-sagi@grimberg.me>
Message-ID: <20161107083639.naen6aolbogpe2ic@linux-x5ow.site>

Hi Sagi,

On Sun, Nov 06, 2016@09:13:01PM +0200, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  nvme.spec.in | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/nvme.spec.in b/nvme.spec.in
> index a4718773a962..e95810995395 100644
> --- a/nvme.spec.in
> +++ b/nvme.spec.in
> @@ -33,6 +33,20 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
>  %clean
>  rm -rf $RPM_BUILD_ROOT
>  
> +%post
> +if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
> +	if [ ! -f /etc/nvme/hostnqn ]; then
> +		install -D /dev/null /etc/nvme/hostnqn
> +		year_month=$(date | awk '{print $6"-"$3}')

Two things, a) are you sure this is correct? I interpret $year_month as year
and month, not year and day (date | awk '{print $6"-"$3}' evaluates to 2016-7
here) and b) 'date +"%Y-%m"' saves you a 2nd process.

Byte,
	Johannes
