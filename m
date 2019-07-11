From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 10 Jul 2019 17:42:25 -0700
Subject: [PATCH rfc 6/6] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190710232740.26734-7-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-7-jsmart2021@gmail.com>
Message-ID: <d9197c71-2386-ba52-088e-183dad4a662a@grimberg.me>


> +	$(INSTALL) -d $(DESTDIR)$(DRACUTDIR)/dracut.conf.d
> +	$(INSTALL) -m 644 ./nvmf-autoconnect/*.conf $(DESTDIR)$(DRACUTDIR)/dracut.conf.d

Where is this file?
