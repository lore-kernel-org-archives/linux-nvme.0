From: jsmart2021@gmail.com (James Smart)
Date: Thu, 11 Jul 2019 09:18:17 -0700
Subject: [PATCH rfc 6/6] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <d9197c71-2386-ba52-088e-183dad4a662a@grimberg.me>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-7-jsmart2021@gmail.com>
 <d9197c71-2386-ba52-088e-183dad4a662a@grimberg.me>
Message-ID: <d62f4fa3-b923-389e-56e8-5de4130ffe17@gmail.com>

On 7/10/2019 5:42 PM, Sagi Grimberg wrote:
> 
>> +??? $(INSTALL) -d $(DESTDIR)$(DRACUTDIR)/dracut.conf.d
>> +??? $(INSTALL) -m 644 ./nvmf-autoconnect/*.conf 
>> $(DESTDIR)$(DRACUTDIR)/dracut.conf.d
> 
> Where is this file?

?? it's not a new file   it's installing 70-nvmf-autoconnect.conf into 
the dracut directories so that dracut will install the udev files in the 
ramdisk.

-- james
