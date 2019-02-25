From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Feb 2019 13:18:10 -0800
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
Message-ID: <71982410-d373-a659-0c0f-8aadf06d1d96@grimberg.me>


> Frankly, we have a ton of testing related special cases in the kernel.
> 
> This one is a) simple and small, only 10 LoC, b) far away from the fast
> path or any other place where it could have any impact on legitimate
> users and c) it prints an informal message showing you what happened.
> 
> Sorry but this is a https://xkcd.com/386/ moment.

How about we just fail it with a proper error message and let the
user set buffered_io instead of trying to get smart here...
