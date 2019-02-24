From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Feb 2019 12:54:01 +0200
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
Message-ID: <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>


On 2/22/2019 7:55 AM, Johannes Thumshirn wrote:
> On 22/02/2019 01:41, Chaitanya Kulkarni wrote:
> [...]
>> As per specified in the patch, this is only useful for testing, then we
>> should modify the test scripts so that on creation of the ctrl we switch
>> to the buffered I/O before running fio.
> Or on any other file-system that does not support DIO..

Do we really want to support these kind of filesystems for fabrics 
backend device ? only for testing ?

What is the status of iSCSI/SRP targets in this case ?


>
>> OR
>>
>> Similar result can be achieved by setting buffered I/O flag
>> buffered_io=1 before enabling the name-space in the test script.
> Frankly, we have a ton of testing related special cases in the kernel.
>
> This one is a) simple and small, only 10 LoC, b) far away from the fast
> path or any other place where it could have any impact on legitimate
> users and c) it prints an informal message showing you what happened.
>
> Sorry but this is a https://xkcd.com/386/ moment.
>
> Byte,
> 	Johannes
