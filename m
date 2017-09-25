From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Sep 2017 09:55:17 +0200
Subject: [PATCH rfc] nvme-cli: NVMf auto discovery systemd service
In-Reply-To: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
References: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170925075517.3kpbkj3snig35hb2@linux-x5ow.site>

On Sun, Sep 24, 2017@04:01:35PM +0300, Sagi Grimberg wrote:
> Run a one-shot discovery (and connect) at system boot time. This
> allows to auto discover and establish nvmf sessions.
> 
> If the user is interested in using this, it should fill in
> one or more discovery endpoints, for example:
> -t rdma -a 192.168.1.1 -s 4420
> 
> This service relies on nvme-fabrics module being loaded, hence
> we add it to modules load at boot list.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Don't have a fedora station near-by, manually tested auto
> discover during boot with systemd service, and it seem to work
> (although I needed to manually get mlx5_ib modules to auto-load
> as for some reason it fails to auto load at boot time).
> 
> We can also add some documentation into discovery.conf to help
> the user add discovery endpoints.
> 
>  nvme.spec.in                   | 19 +++++++++++++++++++
>  systemd/nvmf-discovery.service | 12 ++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 systemd/nvmf-discovery.service
> 
> diff --git a/nvme.spec.in b/nvme.spec.in
> index 0be61e398fd0..c22bdeec9138 100644
> --- a/nvme.spec.in
> +++ b/nvme.spec.in
> @@ -43,12 +43,31 @@ if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
>          if [ ! -f /etc/nvme/hostid ]; then
>                  uuidgen > /etc/nvme/hostid
>          fi
> +        if [ ! -f /etc/nvme/discovery.conf ]; then
> +		touch /etc/nvme/discovery.conf
> +        fi

I don't think having an empty discovery.conf is a particularly good idea, the
contents should be either added by hand or by some configuration/installer
tool (YAST, Anaconda, Chef, Puppet, yada yada).


>  fi
>  
> +# NVMf auto-discovery service
> +install -m 0755 systemd/nvmf-discovery.service /lib/systemd/system/
> +systemctl enable nvmf-discovery.service

Unconditionally starting services will is (at least for SUSE RPMs) a no-go.

> +
> +# we rely on /dev/nvme-fabrics misc device, so auto load nvme-fabrics
> +# at boot time
> +echo nvme-fabrics >> /etc/modules-load.d/modules.conf

This should be done in the systemd unit file I think. Something like this:

> diff --git a/systemd/nvmf-discovery.service b/systemd/nvmf-discovery.service
> new file mode 100644
> index 000000000000..25f7bf1f077b
> --- /dev/null
> +++ b/systemd/nvmf-discovery.service
> @@ -0,0 +1,12 @@
> +[Unit]
> +Description=NVMf auto discovery service
> +After=systemd-modules-load.service network-online.target
> +
> +[Service]
> +Type=oneshot

ExecStartPre=-/sbin/modprobe nvme-fabrics


> +ExecStart=nvme connect-all
> +StandardOutput=journal
> +StandardError=journal
> +
> +[Install]
> +WantedBy=multi-user.target
> -- 
> 2.7.4
> 

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
