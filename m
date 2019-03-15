From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Mar 2019 17:29:13 +0100
Subject: [PATCH v4 3/3] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <a220e95a-32f8-65b4-1591-44408b2d8fa2@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-4-sagi@grimberg.me> <20190312143345.GB1149@lst.de>
 <a220e95a-32f8-65b4-1591-44408b2d8fa2@grimberg.me>
Message-ID: <20190315162913.GB27308@lst.de>

On Tue, Mar 12, 2019@02:07:38PM -0700, Sagi Grimberg wrote:
>> I still wonder why we clamp this down to PAGE SIZE rather than 4k.
>>
>> Everything larger than 4k has a huge chance of not working with most
>> remote hosts, even if our target system has a larger page size.
>
> loop does the same thing, didn't ever hear complaints on that..

loop is always used on the same system exporting things..
