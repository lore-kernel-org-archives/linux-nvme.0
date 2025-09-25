Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E16CAC5B1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zb+ohAeIQWU+uuZeaumJrN8NyMMELCWfjnArbzf2eBk=; b=uOSKg0hvjE/z60yzf37rTwLSPm
	gOchIh80VXVdwqze3dhgcFNeJuNC1z82oVaFaX0EdP8mzO6zXXy293QwOGkRatGTVBwmoZKrJBsFi
	BHATAyAXHabKwjKixquazdo3GA7Z0NlsfpHiiz9ABWyutUQtY4Vy2zwimDQbe8H5+Z87NmX1wGcIO
	r2b3FZAJ9ix6IQXO+ey7LnHFND3EfUYbGN3uwMkN8ml0EUg1gSmGm35mShTHK35YprplDtdA00U0d
	m/HNQAf6UWwfKxN6izQ7rFLIRkDAKHq/8YK8gzw83unaqSCxuehHzuKkBSQB8ekHKjNVaAkB2pdk6
	lfdxQs7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mzd-0000000A497-3FZy;
	Thu, 25 Sep 2025 14:30:45 +0000
Received: from omta038.useast.a.cloudfilter.net ([44.202.169.37])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mza-0000000A3u7-1Ctr
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 14:30:44 +0000
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id 1m2xvJvWOSkcf1mzOvYWW5; Thu, 25 Sep 2025 14:30:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1mzNvRy2IwoI21mzNveZ78; Thu, 25 Sep 2025 14:30:29 +0000
X-Authority-Analysis: v=2.4 cv=PZX/hjhd c=1 sm=1 tr=0 ts=68d55205
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=TDP2S4RWD7HzL5QBIXWMeQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=EvvVDBjTxgXM36QB58gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zb+ohAeIQWU+uuZeaumJrN8NyMMELCWfjnArbzf2eBk=; b=Q0VoIUuVN6rF9ZxM2sBdSvGwEx
	0YgEAX1BkADSQ5ReV17CuFDCBprDT8cohTHwXMhhYl8k+Mt43meojQy5BtDuw7a7tqGwK+0ibLJFr
	CVDwZCpW51+BKNvMpEzDxWtqj/meuJk2WFjsPoSV68gdUvUQBbNfQrig1fPqTRA+VOPztfQQUvTgr
	FyeJmiBUYjv0GZWjrFbDxXuqo4AO2xu2vJ4wPegk8XnALrrLUk+wBu4FCrectxECwijJaz4wIkFIA
	IxVEKIRu7KW1MI9WL6PVU78VJvaJ3qbto/XyJXPa3Cv4GBEICVWCEm+vE6Als/qmsonBVzvw/QyF6
	bOX4BW7g==;
Received: from [83.214.222.209] (port=36200 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1mzK-00000000TGw-10nl;
	Thu, 25 Sep 2025 09:30:26 -0500
Message-ID: <97526d45-ec7d-48a0-bdc6-659f75839f53@embeddedor.com>
Date: Thu, 25 Sep 2025 16:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: John Meneghini <jmeneghi@redhat.com>, martin.petersen@oracle.com
Cc: axboe@kernel.dk, bgurney@redhat.com, emilne@redhat.com,
 gustavoars@kernel.org, hare@suse.de, hch@lst.de, james.smart@broadcom.com,
 kbusch@kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 njavali@marvell.com, sagi@grimberg.me
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
 <fcdb0a83-3b1c-42bd-b58b-b501cfbf27fa@embeddedor.com>
 <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.222.209
X-Source-L: No
X-Exim-ID: 1v1mzK-00000000TGw-10nl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.222.209]:36200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOog1jaJGMEmoxPMj/eRKeppXhccDEddC3cIfCdqr6I2i/F0i84CW8dcn3nWgOWV/zDTXlU7Ef+2u/ohu6RcR3+UWf6YvT6ZebHE0PKr2PaeCdm2D+et
 RC0kY7TPzXlLU+mPqomEq2l8K/uSzvjK9+PXri4CpLuN6NGDK0SZ9OSrEaAFcZov0VOFpPmr5cvt2qpyK6CJXhAHIElqCsQFCOke+qVYt3ch7gfJBgcAxe0j
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_073042_399457_EA087592 
X-CRM114-Status: GOOD (  18.02  )
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



On 9/25/25 16:18, John Meneghini wrote:
> On 9/25/25 9:38 AM, Gustavo A. R. Silva wrote:
>> On 9/25/25 15:07, John Meneghini wrote:
>>> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
>>>
>>> We've been testing this patch and it turns out there is a significant
>>> bug here. This leaks memory and causes a driver hang.
>>>
>>> Link:
>>> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/
>>
>> Thanks for the report. I wonder if you have any logs or something I could
>> look at to figure out what's going on.
> 
> 
> We have a fix already.  Chris and Bryan figured it out.
> 
>> Bryan,
>>
>> Could you please share how this patch[1] was tested?
> 
> Bryan, please reply with bug fix patch you emailed me yesterday as an RFC patch.
> 
> Gustavo, this patch is being tested as a part of our FPIN LI changes. To run this code you need a Brocade switch and a whole lot of hardware.
> 
> You can see a example test plan here: https://bugzilla.kernel.org/attachment.cgi?id=308368&action=view
> 
> I am about to submit a version 10 patch series for these changes and I will include a new/fixed version of your patch in that series.

Awesome, thank you!

I was in the process of writing the following (draft) patch, which is much
less intrusive than the other one:

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index cb95b7b12051..1b000709ccd8 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4890,9 +4890,10 @@ struct purex_item {
                              struct purex_item *pkt);
         atomic_t in_use;
         uint16_t size;
-       struct {
-               uint8_t iocb[64];
-       } iocb;
+       union {
+               uint8_t min_iocb[QLA_DEFAULT_PAYLOAD_SIZE];
+               DECLARE_FLEX_ARRAY(uint8_t, iocb);
+       };
  };

  #include "qla_edif.h"
@@ -5101,7 +5102,6 @@ typedef struct scsi_qla_host {
                 struct list_head head;
                 spinlock_t lock;
         } purex_list;
-       struct purex_item default_item;

         struct name_list_extended gnl;
         /* Count of active session/fcport */
@@ -5130,6 +5130,9 @@ typedef struct scsi_qla_host {
  #define DPORT_DIAG_IN_PROGRESS                 BIT_0
  #define DPORT_DIAG_CHIP_RESET_IN_PROGRESS      BIT_1
         uint16_t dport_status;
+
+       /* Must be last --ends in a flexible-array member. */
+       struct purex_item default_item;
  } scsi_qla_host_t;

  struct qla27xx_image_status {
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index c4c6b5c6658c..a342e137a53a 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1137,7 +1137,7 @@ static struct purex_item
         if (!item)
                 return item;

-       memcpy(&item->iocb, pkt, sizeof(item->iocb));
+       memcpy(&item->iocb, pkt, QLA_DEFAULT_PAYLOAD_SIZE);
         return item;
  }

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 316594aa40cc..065f9bcca26f 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -1308,7 +1308,7 @@ void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp)

         ql_dbg(ql_dbg_unsol, vha, 0x2121,
                "PURLS OP[%01x] size %d xchg addr 0x%x portid %06x\n",
-              item->iocb.iocb[3], item->size, uctx->exchange_address,
+              item->iocb[3], item->size, uctx->exchange_address,
                fcport->d_id.b24);
         /* +48    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
          * ----- -----------------------------------------------


But if you already figured it out, that's great. :)

Thanks
-Gustavo

> /John
> 
>> Thanks
>> -Gustavo
>>
>> [1] https://lore.kernel.org/linux-scsi/20250813200744.17975-10-bgurney@redhat.com/
>>
> 


