From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 13 Jun 2017 09:31:53 +0800
Subject: [PATCH 1/2] nvme-cli: add fields into identify controller data
 structure
In-Reply-To: <20170612161138.GB16226@infradead.org>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
 <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>
 <20170602074600.GA11424@infradead.org>
 <71e89de.8c54.15c69866ff6.Coremail.guanjx09@163.com>
 <20170603052511.GA14365@infradead.org> <20170612161138.GB16226@infradead.org>
Message-ID: <13d37dba-5657-5a91-e90e-b462bad15f74@huawei.com>

Hi, Christoph

On 2017/6/13 0:11, Christoph Hellwig wrote:
> On Fri, Jun 02, 2017@10:25:11PM -0700, Christoph Hellwig wrote:
>> On Fri, Jun 02, 2017@11:57:17PM +0800, ??? wrote:
>>> Hi, Christoph
>>>
>>> On Friday, June 02, 2017 03:46 PM, Christoph Hellwig wrote:
>>>> Please also add them to the kernel copy of the header so that they
>>>> stay in sync.  Except for that his looks fine to me:
>>>>
>>>
>>> Here is the patch which adds those fields into nvme_id_ctrl structure
>>> in the kernel copy of the header. Does it looks good?
>>
>> Thanks, this looks great.  Please send it out formally as a separate
>> mail and your signoff.
> 
> Can I get your Signed-off-by?  Just noticed that it didn't seem to
> be provided anywhere when trying to apply it.
> 
Sure. An updated patch was sent as a separate formal patch a few minutes ago.
Future patches will not be lack of my Signed-off-by.
Thanks

Cheers,
Guan
.
