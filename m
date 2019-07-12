From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 10:26:11 -0700
Subject: [PATCH rfc v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190712003140.16221-11-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-11-jsmart2021@gmail.com>
Message-ID: <a97cd8d1-b36f-828f-12b7-975d3fe219ca@grimberg.me>


> diff --git a/nvmf-autoconnect/nvmf-connect at .service b/nvmf-autoconnect/nvmf-connect at .service
> new file mode 100644
> index 0000000..7d9f856
> --- /dev/null
> +++ b/nvmf-autoconnect/nvmf-connect at .service
> @@ -0,0 +1,14 @@
> +#
> +# Unit file used by 70-nvmf-autoconnect.rules.
> +#
> +
> +[Unit]
> +Description=NVMf auto-connect scan upon nvme discovery controller Events
> +After=syslog.target
> +PartOf=nvmf-connect.target
> +Requires=nvmf-connect.target
> +
> +[Service]
> +Type=simple
> +Environment="CONNECT_ARGS=%i"
> +ExecStart=/bin/sh -c "/usr/sbin/nvme connect-all `/usr/bin/echo -e $CONNECT_ARGS`"

Lets lose the nvme full path, sh allows us to have that (can be in
/usr/local/sbin or somewhere else). and not /bin/echo?
