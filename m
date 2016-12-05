From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Dec 2016 19:06:04 +0200
Subject: [PATCH 3/3] nvme: Make controller state visible via sysfs
In-Reply-To: <20161205153731.GB6529@lst.de>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-4-git-send-email-sagi@grimberg.me>
 <20161205153731.GB6529@lst.de>
Message-ID: <a6d90f76-b4db-1b5a-998c-739eef877dea@grimberg.me>


>> +	return sprintf(buf, "%s\n",
>> +		       (unsigned)ctrl->state < ARRAY_SIZE(state_name) ?
>> +		       state_name[ctrl->state] : "???");
>
> I'd use an if here instead of the ? : and print unknown instead of the ???

I can change that...
