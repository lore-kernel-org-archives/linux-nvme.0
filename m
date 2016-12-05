From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Dec 2016 19:06:44 +0200
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <20161205153400.GA6529@lst.de>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
 <20161205153400.GA6529@lst.de>
Message-ID: <1bbcabad-e586-c92b-ec06-c50f4dd1d09f@grimberg.me>


>> +	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
>> +		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
>
> That's going to be a crazy long line in the dmesg log..

Have a better idea how to provide this information?

>
> Otherwise looks fine:
>
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
>
