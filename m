From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 18:19:41 +0300
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <20171018201713.GA1971@localhost.localdomain>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
 <20171018150859.GD32530@localhost.localdomain>
 <4627b34e-449a-cd93-ac70-a628d558cac3@grimberg.me>
 <20171018201713.GA1971@localhost.localdomain>
Message-ID: <9942d9a3-89b7-84ee-1579-ab8e00b71e6a@grimberg.me>


> Hm, I'm not hitting duplicate name issues anymore. I can't be bothered
> to bisect when that started working, but I think the dev_t lifetime
> fixes has something to do with it.
> 
> Anyway, simpler is certainly preferred. This is looking okay so far,
> and I'll try a few more things to see if I can break it.

Thanks Keith,

Would be good to get your review/tested tag if it survives your tests.
