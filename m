Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA2C7115B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJ2Hjv2INl2RCqpxVtU/rThCxprxUjoNNXkB85dpm6c=; b=2sG6TU0RIr4mwgj7t/LH/WsHqI
	nM1UKXf+ifQFO7CTIkj2C8DBHRn6kCQ6ILiDsN72hJnwLkXOc8HizzKUT73II+naOup/r5PfXLJfA
	S2aYgYxVJU+WjWkpmpNU/pSSxGUDiW78MO0Ae9DdRlKoXiKwKjrGOvfSgEI9/Vm53u3xcsm0/Pkzc
	Xu9FjnxIYJgSqy0QzG7GqD8rb6SCsf0RUuZ9mA3YxO/HBPc72WmtNMzxuh+2Ht0tivgEefk60socx
	jG9PUd6M55EbhuAF5fQ4lhC6+9hkX6KBRD3SSi3Yv2aFK8ZPH5dkw7YaeXd5m1NqjmN/fzWALSuw+
	HFgE3Raw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhFj-0000000ApfU-3lR6;
	Thu, 26 Jun 2025 07:42:35 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhCH-0000000ApEG-3IkP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 07:39:03 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSVtL3z84zYQtyL
	for <linux-nvme@lists.infradead.org>; Thu, 26 Jun 2025 15:38:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 74FF91A14E3
	for <linux-nvme@lists.infradead.org>; Thu, 26 Jun 2025 15:38:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8H+VxoqrPIQg--.21494S3;
	Thu, 26 Jun 2025 15:38:49 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Calvin Owens <calvin@wbinvd.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
 <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
 <aFtUXy-lct0WxY2w@mozart.vkv.me>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <49536e03-ba8d-8b15-413c-968c2147b81d@huaweicloud.com>
Date: Thu, 26 Jun 2025 15:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <aFtUXy-lct0WxY2w@mozart.vkv.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8H+VxoqrPIQg--.21494S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw
	0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_003901_974920_8D45C8C1 
X-CRM114-Status: UNSURE (   7.14  )
X-CRM114-Notice: Please train this message.
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

Hi,

在 2025/06/25 9:43, Calvin Owens 写道:
> I can confirm it's what you expected, I've reproduced the original
> warning with your patch while not seeing any of the new ones.
> 
> If you like, for the revert:
> 
> Tested-By: Calvin Owens<calvin@wbinvd.org>

Thanks for the test, I'll send the revert with your tag.

Kuai


