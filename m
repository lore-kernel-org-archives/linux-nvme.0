Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3957CD8CA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nimoDvdBIUbSLQaqpIpinymiSR+n9X33u+IjT0/Xomk=; b=YiQbB+Qk2MITaH2IBC+9KUhKJb
	O2WWL0/YuqSsf2qfqhcu5iso1FsL1bmTIlszU2652RvXI8nC76iLUgySx9aJc8FFnS0AjydJkZNdE
	InqUOjDTWmhGjhpXjdKmo3SK/9RokRnXODr7CfxDrwUzV/eVIAXOqaHxo6UXxPmCeQbJdKbRCUe/2
	uh/CVKCTK0bfHJMBnPcSLUYtVyYfRwH3nX/FiGAwh+amoK1LckxoqszP/Ni8Z7x744DccCAU4C9Yw
	pmpjE39ZsKkKAxlRaOVxgEGUZd/v9By7IUGPdIWdrhN5RxSeSHCNyHakWE+xS62f0XSzHh6EMDvHK
	DRhDIhEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWsGN-000000057XL-02rX;
	Tue, 09 Jun 2026 08:56:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWsGL-000000057Wr-21aS
	for linux-nvme@bombadil.infradead.org;
	Tue, 09 Jun 2026 08:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nimoDvdBIUbSLQaqpIpinymiSR+n9X33u+IjT0/Xomk=; b=WhiH8mrs0fHlwVS2WXVhyGfVxY
	ZddYCO5fKHfYSGpOmkBAseff+hVL3dQjjTTWQSF150vxD/qSnAJJPPhhgAp8uK9DlVKksLtVOQb83
	3mzDyf7d36MIJ0uL70dqn19vTKPh7fF73z6N2dNwlCS9Vo6XOha91dPt/5py0ZNNvQiE8uK0jTQ4s
	f5JIBsk4ZuoSH6r9+YGONzNLUeZ7/5+6QgLuQkChDkkcjk5evbktrQUcFywD8+KXHIZCuGQB40ZIk
	7ppfKgB7tVu4ywLe7ptZIDhuamVcm7USDEvgB89n8gfhchfOf5uwoyMSRjwz+9Do8XyniE9+toscV
	eYFQBI5w==;
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWsG7-00000002CxQ-0Mga
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 08:56:42 +0000
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZN6H68Q4zKHMTp
	for <linux-nvme@lists.infradead.org>; Tue,  9 Jun 2026 16:55:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 24EB54056E
	for <linux-nvme@lists.infradead.org>; Tue,  9 Jun 2026 16:56:11 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP1 (Coremail) with SMTP id cCh0CgB3eT4n1Sdq8CapBA--.986S3;
	Tue, 09 Jun 2026 16:56:09 +0800 (CST)
Subject: Re: [PATCH 2/2] nvme: avoid possible double completions for the same
 request
To: Keith Busch <kbusch@kernel.org>
References: <20260608113425.3836619-1-yebin@huaweicloud.com>
 <20260608113425.3836619-3-yebin@huaweicloud.com>
 <aibdA7YtCt5OS1EQ@kbusch-mbp>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <6A27D527.7060008@huaweicloud.com>
Date: Tue, 9 Jun 2026 16:56:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <aibdA7YtCt5OS1EQ@kbusch-mbp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgB3eT4n1Sdq8CapBA--.986S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15Xw1rJryfGrW3CrykKrg_yoW8Ar18pF
	4jgay3Cry7Xw4xK3yDJr4kZFWFy393AFZrGF1rta9FvF1Ygrn2vF40grWY9an5ZryF9r12
	vF4UKrW3ur12va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_095640_057525_1B9ACD4C 
X-CRM114-Status: GOOD (  19.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2026/6/8 23:17, Keith Busch wrote:
> On Mon, Jun 08, 2026 at 07:34:25PM +0800, Ye Bin wrote:
>> To avoid the preceding problem, the NVME_REQ_COMPLETE flag is added by
>> referring to the implementation of scsi commit f1342709d18a ("scsi: Do not
>> rely on blk-mq for double completions").
>
> That scsi commit was solving a different problem for a racing
> interaction between the low level driver and the timeout handler and
> error injection. It wasn't about protecting against misbehaving
> hardware.
>
>>   static inline struct nvme_request *nvme_req(struct request *req)
>> @@ -807,6 +808,8 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
>>   	nvme_should_fail(req);
>>   	if (unlikely(blk_should_fake_timeout(req->q)))
>>   		return true;
>> +	if (unlikely(test_and_set_bit(NVME_REQ_COMPLETE, &rq->flags)))
>> +		return true;
>
> I think you need to invert this flag from "COMPLETE" to "INFLIGHT",
> because the default allocated state is that this flag is cleared, so
> this check as you have it wouldn't catch a phantom completion to a
> request the host never sent.
>
> You also have this check after the driver updated its internal
> generation counter for a bogus completion, so now our actual state could
> be off from what's actually being prepared.
>
> This previous proposal for a similar problem was probably more on the
> right track:
>
> https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@gmail.com/
>

Thanks for your reply.
This solution is indeed more accurate.

> However, I'm really skeptical controllers actually behave this way. You
> wouldn't have a viable storage device if it was doing this.
>


