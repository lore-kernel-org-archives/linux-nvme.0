From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 15 Mar 2019 10:18:39 -0700
Subject: [PATCH v4 3/3] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <20190315162913.GB27308@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-4-sagi@grimberg.me> <20190312143345.GB1149@lst.de>
 <a220e95a-32f8-65b4-1591-44408b2d8fa2@grimberg.me>
 <20190315162913.GB27308@lst.de>
Message-ID: <a2fc1190-9a20-8eea-81f5-b71b737c856f@grimberg.me>


>>> I still wonder why we clamp this down to PAGE SIZE rather than 4k.
>>>
>>> Everything larger than 4k has a huge chance of not working with most
>>> remote hosts, even if our target system has a larger page size.
>>
>> loop does the same thing, didn't ever hear complaints on that..
> 
> loop is always used on the same system exporting things..

Yea, I see what you're saying... I can change it to 4k.
