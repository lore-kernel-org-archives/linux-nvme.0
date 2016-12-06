From: hch@lst.de (Christoph Hellwig)
Date: Tue, 6 Dec 2016 09:28:26 +0100
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <1bbcabad-e586-c92b-ec06-c50f4dd1d09f@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
 <20161205153400.GA6529@lst.de>
 <1bbcabad-e586-c92b-ec06-c50f4dd1d09f@grimberg.me>
Message-ID: <20161206082826.GC12194@lst.de>

On Mon, Dec 05, 2016@07:06:44PM +0200, Sagi Grimberg wrote:
>
>>> +	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
>>> +		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
>>
>> That's going to be a crazy long line in the dmesg log..
>
> Have a better idea how to provide this information?

Not sure.  Maybe multiple lines?
