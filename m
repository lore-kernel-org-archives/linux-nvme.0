From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 15:17:52 -0700
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <20190723223144.GE4002@localhost.localdomain>
References: <20190719194256.23618-1-sagi@grimberg.me>
 <20190723204643.GC4002@localhost.localdomain>
 <6e5af7f5-be2a-6cf8-81fc-84ed831cbacd@grimberg.me>
 <20190723223144.GE4002@localhost.localdomain>
Message-ID: <47efa114-a0e9-9631-3104-8c1e0c9f4827@grimberg.me>


>> I think you need to get the ref first and then fire the work right?
> 
> That ref order doesn't actually matter here. We can't call nvme_remove
> during the synchronous part of probe, and the extra ref is just for the
> async_schedule callback.

Makes sense,

Can you send a proper patch?
