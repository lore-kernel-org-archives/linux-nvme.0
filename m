From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 17:58:16 +0300
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <20171019144925.GA23650@lst.de>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
 <20171019084926.GA14227@lst.de>
 <9604c4ac-0a0f-a029-1894-051e6de50072@grimberg.me>
 <20171019102022.GC17326@lst.de>
 <9cb7f448-f4a3-e3e6-e906-749a56daa943@grimberg.me>
 <20171019135522.GF21452@lst.de>
 <d5177951-d869-786d-77ad-679929daf834@grimberg.me>
 <20171019144925.GA23650@lst.de>
Message-ID: <94390d33-dc54-b8ae-ed9a-ba49c4f71ae0@grimberg.me>


> Actually, let's skip the idea - I just noticed nvme_rdma_alloc_tagset does
> way too many different things for the admin vs io taget.
> 
> I'm fine with your original version, but once we refactor things in this
> area I have a few ideas how to improve things.

I have no doubt you do...
