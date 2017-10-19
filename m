From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 17:04:07 +0200
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <94390d33-dc54-b8ae-ed9a-ba49c4f71ae0@grimberg.me>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
 <20171019084926.GA14227@lst.de>
 <9604c4ac-0a0f-a029-1894-051e6de50072@grimberg.me>
 <20171019102022.GC17326@lst.de>
 <9cb7f448-f4a3-e3e6-e906-749a56daa943@grimberg.me>
 <20171019135522.GF21452@lst.de>
 <d5177951-d869-786d-77ad-679929daf834@grimberg.me>
 <20171019144925.GA23650@lst.de>
 <94390d33-dc54-b8ae-ed9a-ba49c4f71ae0@grimberg.me>
Message-ID: <20171019150407.GA24110@lst.de>

On Thu, Oct 19, 2017@05:58:16PM +0300, Sagi Grimberg wrote:
>
>> Actually, let's skip the idea - I just noticed nvme_rdma_alloc_tagset does
>> way too many different things for the admin vs io taget.
>>
>> I'm fine with your original version, but once we refactor things in this
>> area I have a few ideas how to improve things.
>
> I have no doubt you do...

In the meantime can you write a more detailed changelog?  For a late
rc fix I'd really like to have a better description especially with
Linus hating us block and nvme people at the moment :)
