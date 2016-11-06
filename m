From: hch@lst.de (Christoph Hellwig)
Date: Sun, 6 Nov 2016 20:25:30 +0100
Subject: [PATCH RFC nvme-cli 1/2] debain: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <1478459581-22654-2-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-2-git-send-email-sagi@grimberg.me>
Message-ID: <20161106192530.GB18342@lst.de>

I think the subject should read "debian" :)

> diff --git a/debian/prerm b/debian/prerm
> new file mode 100644
> index 000000000000..40c6fea42284
> --- /dev/null
> +++ b/debian/prerm
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +if [ "$1" = "remove" ]; then
> +    rm -rf /etc/nvme
> +fi

Shouldn't we only do that for a purge?
