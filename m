Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5DBD0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DXH4CWUeaiRSiyHNB2ROfD6B4gJPBs0ygaqh3TJaAo=; b=tYxAb2Kd7bXKu5i5UQMQc9ki7p
	ZpVetDWtGeGeuGcsjPhD9jAcsQeEfSLrwFrSJB6PFi3YHnxgEv3gw8pabUMoz/Q/kWjdR8FfPlKya
	Qu8GWvOlbePaDOrzA7gWl5GsAHt+uGG+QLOKDWch5l4/uKqMqsh+U7Lk4HKHB3RzI59/BtYuWAkwt
	bLgvUcItaAUZYb8pXSGrQjkYCUvsRuxNVaQQ+VlJgiLiFJq2uKT1eHU/rmhXuLIvr0gtCUwts9STa
	CtU5RfQItIhFtG8CAuN6YGZb9De0uOAuRaLnTUYUjvq+lugn6hCaWB8NWMzNXxFjw2YZgafzusnrg
	/0Biw5qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mmd-0000000GR4z-3TBm;
	Thu, 24 Oct 2024 01:37:03 +0000
Received: from omggw0016-vm0.mail.otm.yahoo.co.jp ([182.22.18.249])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mjR-0000000GQiR-1Fcx
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:33:47 +0000
X-YMail-OSG: ROoMa18VM1mKlGjLtWd.aQredS3.TKfO9VCP42jAHoGxI62uyTyo6WCnrlny3.e
 sAWdUy6LS_ZkTFQ9gHQQuIidMaduMvyvXKc_e_ze8Ut_dMj8MsxA_Q6zxCLi.7vYWLbd_I4KuPjD
 lzObXRCzlRQeV817PAQIQ0yiUXTGAg74odASf0g4nH4bzmAI9cK2mgm2WpK2W6Clclv1d7GsNdvt
 vNFpqvPe2LpyQ4fPPChkGNA5ZQBmP7jQ030OlImbGtExZYCKo5_ocTsMyf_xl4KvZMM0rJwEFnII
 Y19XNbDqpSI5UdxUgntUk9nErt5S6SlPap_5RgY8QowaZLT_jSMBjjYrz3LrsQ9UCd.aTmtFgKYm
 o7piNcjZ.xspaJdShWUKmLth8Bws1ubvrn3NlBmuwi0CVBz7BqXa5Kwslypy28H4wvrJH5BMFteI
 RMJyROk0oIHUuoRtczNMyj2AE1A01Zu5KAf86TE98Z9NVXniCasiqhwGuz8v9oII8mg_8Wr0cIFv
 YSmv3DVJtaL35yDzda_iDwgpamLdDK_tV3ycU3qgjqUGlRuhc9MiKdLq3ZGpkF6aML.mKisPfuta
 CBF1NkQ1oGp.yU480acw3FFQ_8SIueq_Cpjl0X5Ewf61uhkOAtvyFtu8FDs382hyf6UajfQpiRn4
 K_b9ijY3aiv4u3yJfiqAFl_PJJcFcmOx8hMfyMyAJ_UU_PM26W1BFD6.FQ09DIv9URniQe4vSnR4
 l1PcdchX_46IMDbuX.TgGU4F6TjOErnnORt1DR9T84DiJEVt33exoWlRjSRWOCRcLIwN.xn9Wdxl
 MgvwUzBgMlFNLwj.mUiPBjgHAyBXAoWF2te_Pr8BLsu7HX78EgrYFPa6H84.KtXNm4SNHXmOewqr
 YcCuEn_6S64mc5fKJ4h17aYooh2KPdZYtR7aPK16v_vYADDsNt13ddwflbRtb8jYIpNQ36pv.j2M
 TglKdv_bEKZPCQ5MCppNjP572md8mA2bXDIyNrtuUk3uxzmLwNgbnsibMeeEsI94lWfA89OBOU.j
 VxL7i4FHeQXT_RvO6B.a1LbCLcyYtvROOggdYBOKbdhtBKr3XP8mccHNwksjCFLoX_EnqsGNaD4V
 lURKZKPXYndqt2xqms.fHogXVToPBQRI2O3LzMNx4WApveoKB5cn8ZwRzQ3qClMENB.LGIbVT4tl
 HySpM.n1eYt.4zi0LbMmSaus7VJx8KJ540f73yYKQvUzBvqyd7XzU09ueAiM4WulUUAlS
Received: from sonicgw.mail.yahoo.co.jp by sonicconh6001.mail.ssk.yahoo.co.jp with HTTP; Thu, 24 Oct 2024 01:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729733613;
	s=yj20110701; d=yahoo.co.jp;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=8DXH4CWUeaiRSiyHNB2ROfD6B4gJPBs0ygaqh3TJaAo=;
	b=YPdXPW2G8W8ZT8XAKzknrE/Xcxc5ZfRNvnmsbVzhhnBFffYRKchkeN+beHhLzDSx
	Kg1TxgBLXRgdwsW8Kw9oBkhjpTtA4CtUmTKy+cM/Xeuw45mmGDjuJzRB3EIfWIHSCun
	ckWjhkiALuqBSkG6N1p89UHVZe73AccT4yzaoxtY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=yj20110701; d=yahoo.co.jp;
	h=Message-ID:Date:MIME-Version:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=E+3TN1Q8DrhB5cVq7AykKhy+qXbRg8TlvQUx9B0bptN4zAJOUmRS5CVFZcFqJuy2
	L8mSFPu0IhjxSqB0Pc3lVcndOzzPfHUg2nXt8EzqJRPzFdeL9DTgUQpdRkRuXZQov2J
	u1FH3sGy5caI/zhNQppH17XeREzGnAl/2GEuIDdA=;
Received: by smtphe6009.mail.ssk.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with ESMTPA ID bcb02ba28bc029ec29d816d0e1a08156;
          Thu, 24 Oct 2024 10:33:34 +0900 (JST)
Message-ID: <47f4825c-9f9a-4fc4-9951-6548783e8149@yahoo.co.jp>
Date: Thu, 24 Oct 2024 10:33:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
To: David Wei <dw@davidwei.uk>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "joshi.k@samsung.com" <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
References: <20241023155048.634988-1-kbusch@meta.com>
 <cb19f610-b6b3-4dde-9d1a-88446dc0615f@nvidia.com>
 <Zxla500xnmoKVrpB@kbusch-mbp>
 <3e97f4e9-e657-42f4-aaa0-a7200bedfe03@davidwei.uk>
Content-Language: en-US
From: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
In-Reply-To: <3e97f4e9-e657-42f4-aaa0-a7200bedfe03@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_183345_681931_4CC5CA28 
X-CRM114-Status: UNSURE (   9.89  )
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

Seems can be changed as below also.

tokunori@tokunori-desktop:~/linux$ git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a7f7ce2bc49..59bb656a1d5e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1768,6 +1768,12 @@ static bool nvme_init_integrity(struct 
nvme_ns_head *head,
             !(head->features & NVME_NS_METADATA_SUPPORTED))
                 return nvme_ns_supports_pract(head);

+       bi->tuple_size = head->ms;
+       bi->pi_offset = info->pi_offset;
+
+       if (disable_pi)
+               return true;
+
         switch (head->pi_type) {
         case NVME_NS_DPS_PI_TYPE3:
                 switch (head->guard_type) {
@@ -1808,8 +1814,6 @@ static bool nvme_init_integrity(struct 
nvme_ns_head *head,
                 break;
         }

-       bi->tuple_size = head->ms;
-       bi->pi_offset = info->pi_offset;
         return true;
  }

On 2024/10/24 6:21, David Wei wrote:
> On 2024-10-23 13:21, Keith Busch wrote:
>> On Wed, Oct 23, 2024 at 08:01:43PM +0000, Chaitanya Kulkarni wrote:
>>> @@ -1774,9 +1773,9 @@ static bool nvme_init_integrity(struct
>>> nvme_ns_head *head,
>>>                   return nvme_ns_has_pi(head);
>>>
>>>           if (disable_pi)
>>> -               pi_type = 0;
>>> +               goto out;
>> I'm not against 'goto' in principle, but I try to restrict it to
>> unwinding an error, and this isn't an error. I know, personal preference
>> and all...
> Agreed. This is more unreadable and a modern compiler will most likely
> do the right thing anyway.
>
>

