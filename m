Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF9C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IA6KYss+v8EJWlLj3rm0SQzjogy4/894RSormeleiK0=; b=mj/l0u8Gg1usdxExPPBECszKkC
	XSk1Oy1hn4ya/aGABpYN9W5HgtBRfQaabm/xrhpTJXfX84sIKSUs2D125WP5y4yLVurVjYPivHe9r
	2Hu1dOBBBeXkWU93dEW9FfibKcc8lOXiEskOX5uwdD/7vAVa3du6/jTkUfE0S/VWojS86bB8H0Y1N
	QE4Hml0LEpoyGkkUNFYPItzNhMNA28cGCGsMmj6i+Zext+oMi56XhOnJr6gS9kYwn5hxHr/x7ef7E
	emQMQwrOmlGhNGFa04PSaWaxvL5BPktFz/z6OHexVpmDaftQ0IqDr2XDXHoDYPErV63VcwoNAu25P
	PChwW2QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFO7-00000008UUa-2Sya;
	Wed, 28 Feb 2024 08:34:03 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFO4-00000008URn-1zzz
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 08:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709109236; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IA6KYss+v8EJWlLj3rm0SQzjogy4/894RSormeleiK0=;
	b=pckSSCmI4sVG3nyxnh4++O9+iWfOhYZ25+C3L9r/d+VwZair5qM3lKGK8W5AwDbz4hNKTBnQ4m1L1apMkSlkW/EQC1FJHwjl7+NJ24ST7MhOtWN/ljs2xBLUjqsbV38f1zS+p6fGX5pkyX+luwWWIrTKAMy8ynSF+GjKDwTieT0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1PIwGH_1709109232;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1PIwGH_1709109232)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 16:33:54 +0800
Message-ID: <8a4b7d61-ef9b-4c15-9a58-224ade1020bb@linux.alibaba.com>
Date: Wed, 28 Feb 2024 16:33:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: add tracing of zns commands
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240228023118.84959-1-kanie@linux.alibaba.com>
 <20240228023118.84959-2-kanie@linux.alibaba.com>
 <b6e63b26-f5df-4ead-aad6-06f7c214373e@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <b6e63b26-f5df-4ead-aad6-06f7c214373e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_003401_069992_B5387E80 
X-CRM114-Status: GOOD (  10.31  )
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


在 2024/2/28 13:25, Chaitanya Kulkarni 写道:
> On 2/27/24 18:31, Guixin Liu wrote:
>> Add nvme_cmd_zone_append, nvme_cmd_zone_mgmt_send and
>> nvme_cmd_zone_mgmt_recv parse to nvme target tracing.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    drivers/nvme/target/trace.c | 34 ++++++++++++++++++++++++++++++++++
>>    1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
>> index 657bd31841b2..6604e5fe57d8 100644
>> --- a/drivers/nvme/target/trace.c
>> +++ b/drivers/nvme/target/trace.c
>> @@ -119,6 +119,35 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
>>    	}
>>    }
>>    
>> +static const char *nvmet_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
>> +{
>> +	const char *ret = trace_seq_buffer_ptr(p);
>> +	u64 slba = get_unaligned_le64(cdw10);
>> +	u8 zsa = cdw10[12];
>> +	u8 all = cdw10[13];
>> +
>> +	trace_seq_printf(p, "slba=%llu, zsa=%u, all=%u", slba, zsa, all);
>> +	trace_seq_putc(p, 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static const char *nvmet_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
>> +{
>> +	const char *ret = trace_seq_buffer_ptr(p);
>> +	u64 slba = get_unaligned_le64(cdw10);
>> +	u32 numd = get_unaligned_le32(cdw10 + 8);
> please use consistent notation :- &cdw10[8]
It will be changed in v3.
>> +	u8 zra = cdw10[12];
>> +	u8 zrasf = cdw10[13];
> why not decode zrasf values 0h-9h to make it more readable ?
> printing number only will make a trip to the spec since I don't think
> everyone will remember those values all the time , more importantly
> this will also help in testing to grep for right string when using zrasf.
>
> same goes for zsa I guess above ...

Agree, I will translate zrasf and zsa to a readble string, and print them.

Best Regards,

Guixin Liu

>

