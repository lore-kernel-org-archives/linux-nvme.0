From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Dec 2017 21:04:43 +0200
Subject: How to Persistent nvme Storage?
In-Reply-To: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
Message-ID: <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>

Tony,

> Dear All:
> 
>        I download the new nvme multipath version (git clone from
> git.infradead.org nvme.git),I want to know how to use the
>        multipath, because I want use udev to Persistent Storage,But
> when use scsi_id command not found any messages.
>        What method can nvme achieve multi-path? Can you provide an
> example? Thank you

If you opt in CONFIG_NVME_MULTIPATH the nvme device nodes you see
will actually be multipath devices (no scsi device identification
needed). Johannes submitted a nvme-cli code to get some more information
wrt to multipathing.
