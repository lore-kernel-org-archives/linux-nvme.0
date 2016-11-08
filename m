From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 8 Nov 2016 12:29:10 +0200
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <1478550329.5463.7.camel@linux.intel.com>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-3-git-send-email-sagi@grimberg.me>
 <1478550329.5463.7.camel@linux.intel.com>
Message-ID: <782d4021-539d-20a9-5979-d56a2b6a0017@grimberg.me>


> Hey Sagi,
>
> 7.9 of the base NVMe spec makes it clear on unique names that the "2nd
> format", which is what is being assembled here, uses a fixed date
> "2014-08" in it's name, which is exactly what the NVMe Host driver does
> as its default:
>
> fabrics.c:  "nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUb", &host->id);
>
> I would just do what the NVMe host is doing already and make it easier
> on yourself ;-).

I'm fine with that...
