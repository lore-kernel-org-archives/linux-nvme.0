From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 15 Mar 2019 17:44:40 +0800
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <20190315092020.GA2405@lst.de>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190315092020.GA2405@lst.de>
Message-ID: <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>



On 3/15/19 5:20 PM, Christoph Hellwig wrote:
> On Fri, Mar 15, 2019@04:57:36PM +0800, Jianchao Wang wrote:
>> Hi Jens
>>
>> As we know, there is a risk of accesing stale requests when iterate
>> in-flight requests with tags->rqs[] and this has been talked in following
>> thread,
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dscsi-26m-3D154511693912752-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn_onIetKEehM&s=ZQ7RfO6-737-t5kQv7SFlXMhIdpwn_AxJI93d6c-nj0&e=
>> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D154526189023236-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn_onIetKEehM&s=EBV1M5p4mE8jZ5ZD1ecU5kMbJ9EtbpVJoc7Tqolrsc8&e=
> 
> I'd rather take one step back and figure out why we are iterating
> the busy requests.  There really shouldn't be any reason why a driver
> is even doings that (vs some error handling helpers in the core
> block code that can properly synchronize).
> 

A typical scene is blk_mq_in_flight,
                          
blk_mq_get_request         blk_mq_in_flight
  -> blk_mq_get_tag        -> blk_mq_queue_tag_busy_iter
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q       //---> get a stale request
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq

This stale request maybe something that has been freed due to io scheduler
is detached or a q using a shared tagset is gone.

And also the blk_mq_timeout_work could use it to pick up the expired request.
The driver would also use it to requeue the in-flight requests when the device is dead.

Compared with adding more synchronization, using static_rqs[] directly maybe simpler :)

Thanks
Jianchao
