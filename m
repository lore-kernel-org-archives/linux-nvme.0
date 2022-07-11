Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BCC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K+A7Xq0Dtg1M28AX2pm6iq7+K2wlhOA1YKzGE8z96xA=; b=hOtBsntoX1Ft/bSmdbiW1kMQgs
	44Smt9JDO+amLFFW+wwN9jlR5s6+G6DcQukjG0z4W0rDZ1fkQhqRsWYOc8mOCtlXR1fiefanX1FHx
	4FzppwHY/RaWGIbZuvu9oOF6TtpVm2S/CfBGutWuazfAlQjbJPQcQRriK3LzopDWhi0wmQ79HVW4J
	bOpg8ivuEXGhG/TeaCOjMVU5pa3Bf3hR/p7aWTxm91d3CXBUg3TTI0mSDtmKif+C44bmQKWJ+Mhpu
	eOwbWMenqhS0WBKovCTkBtO/vFnYoOhLHIXYZLsr7Nw08mt5MXUAG/hU/K8PYotYUgUNIWsVgf6AU
	NV3uYyNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAv5W-002mNW-MJ; Mon, 11 Jul 2022 15:12:42 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAv5U-002mKJ-FJ
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 15:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=K+A7Xq0Dtg1M28AX2pm6iq7+K2wlhOA1YKzGE8z96xA=; b=ratBO5EA5ds+0wKQOD4let/B32
	Aj2p5qOJmxyMmtY0WdwaAVsGUumqNmum7z3V+13nIUCI3uwXpoGoMQYumZYYC8Fj0s6K5v6eJQCxf
	vcbx471HkEdRoS+ZJXccc7y07U8mAUhLrxoR9UJT8hYUE63gAGxZDC7l9HW9e6TiCpdBk3HSeh5Lb
	Zo6bAeTbGVzwoug5qeRckCXmmDQai/wsUwHN+Jy9FqXwY8JdjTjtfhtSWoHtZ9Tf8Re0puRh65VZ4
	5To4VC9qOKFVdSvaT/aqXun/rqArJjv/HTPqNueC7e+nLGfpScQIkP0Fo2WTi6cknKlOBXtAAzRhB
	XNppXIItFtblsBHmujlJOJDSMi6SwM23q6tVW2uzOTJXir+h3ptwR9doqsXd+qFuSu6PcQxBkU/GY
	xgBC4DDOlr5M/RXY00cpAcc/W4snU6cGCDjXYrVS19R12nyWHUpOjl9QcC0aD8hji7zmfR1ELKg+W
	zEpdqk34C2kWsJtW1OBIIWYE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1oAv5D-004BnU-TL; Mon, 11 Jul 2022 15:12:23 +0000
Message-ID: <5c71b8f6-afec-8ef6-0a70-d13e71ded79c@samba.org>
Date: Mon, 11 Jul 2022 17:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_081240_540655_95DA3E26 
X-CRM114-Status: UNSURE (   8.53  )
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

Hi Sagi,

>> @@ -189,6 +190,12 @@ enum {
>>       NVME_REQ_USERCMD        = (1 << 1),
>>   };
>> +static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
>> +        struct io_uring_cmd *ioucmd)
>> +{

Shouldn't we have a BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
here?

>> +    return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
>> +}
>> +

>> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>> index d734599cbcd7..57f4dfc83316 100644
>> --- a/include/linux/io_uring.h
>> +++ b/include/linux/io_uring.h
>> @@ -15,6 +15,8 @@ enum io_uring_cmd_flags {
>>       IO_URING_F_SQE128        = 4,
>>       IO_URING_F_CQE32        = 8,
>>       IO_URING_F_IOPOLL        = 16,
>> +    /* to indicate that it is a MPATH req*/
>> +    IO_URING_F_MPATH        = 32,

Isn't that nvme specific? If so I don't think it belongs in io_uring.h at all...

metze



