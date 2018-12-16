From: hch@lst.de (Christoph Hellwig)
Date: Sun, 16 Dec 2018 17:24:57 +0100
Subject: [PATCH 1/3] nvmet-tcp: fix endianess annotations
In-Reply-To: <631dd9ef-5ce6-27d4-8a4f-ca625cc816bb@grimberg.me>
References: <20181213085107.17183-1-hch@lst.de>
 <20181213085107.17183-2-hch@lst.de>
 <631dd9ef-5ce6-27d4-8a4f-ca625cc816bb@grimberg.me>
Message-ID: <20181216162457.GA12572@lst.de>

On Thu, Dec 13, 2018@08:42:15AM -0800, Sagi Grimberg wrote:
>
>> @@ -776,7 +776,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>>   	icresp->hdr.pdo = 0;
>>   	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
>>   	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
>> -	icresp->maxdata = 0xffff; /* FIXME: support r2t */
>> +	icresp->maxdata = cpu_to_le32(0xffff); /* FIXME: support r2t */
>>   	icresp->cpda = 0;
>>   	if (queue->hdr_digest)
>>   		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
>
> This needs an actual fix, we need to send 0xffffffff as we don't have
> this any limitation..

Can I get an ACK for this for now?  I can also send the proper fix
on top then..
