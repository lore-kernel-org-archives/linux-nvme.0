From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 08:52:09 +0300
Subject: [PATCH] NVMe: Added another device ID with stripe quirk
In-Reply-To: <20170706232253.GA11119@lst.de>
References: <1499379151-32479-1-git-send-email-david.fugate@intel.com>
 <20170706221754.GA10217@lst.de> <20170706223955.GA1200@localhost.localdomain>
 <20170706232253.GA11119@lst.de>
Message-ID: <a01eeb47-7566-05fb-4d8b-db5ddef36b82@grimberg.me>


>> That's true for all Intel controllers going forward, but this
>> is actually an older controller that pre-dates NOIOB. It's the exact
>> same as the 8086:0A54 model, but a particular vendor decided their
>> rebranded device needs to be made special with a different DID.
> 
> Meh..
> 
>>
>> We all agree that's a terrible way to go about this for mutliple reasons,
>> but we can't go back in time to tell the decision makers of this folly. So
>> I think we need to let this last one go through with the quirk.
>>
>> Acked-by: Keith Busch <keith.busch at intel.com>
> 
> Reluctantly-accepted-by: Christoph Hellwig <hch at lst.de>
> 

David, can you resend the patch? For some reason I
can't locate it in my mailbox...
