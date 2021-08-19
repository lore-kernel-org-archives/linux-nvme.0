Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988DC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 02:38:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E99B60FC1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 02:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E99B60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzPJwaf8K2wOyefwqAZSTBCbZN3rCmidAL5pJ/LbQX8=; b=GTajZbYdU5cuInfQgUYkOLPRDr
	4V8CyPrv8dRCl47EjpLtoA+nTES095kvnY0g56YLJF8yMzwTm1uUQYH30JktBMV2MOpaVG1QykXre
	bcQmPeXTmihH2u2JBkBzCGiB5/EZXdZOwKc5IalVws/1ngADnOM7Usv08pu43F0N4ztbSDfRMrhP/
	mRTQNwYJw9tPGvfO7aSDzIkbecoO0CoiWgfJ+HyRHLB0kofgm5bnn6uxyB3u2Fg8CrIgmbiDa3aYg
	pvSZS53fuZovPHp0A65Pe6EOzf+PXIK9SEBQDx+bet4DncQb0HnJzC/iB1tZSQk01a/Xhz+pGHTLA
	t6L5CZ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGuPJ-009vBv-0S; Fri, 20 Aug 2021 02:37:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGuPD-009vB3-3U
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 02:37:19 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210820023708epoutp011f9a017847f087d102b8fe1ad1558041~c4z-SEM_N3074830748epoutp01e
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 02:37:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210820023708epoutp011f9a017847f087d102b8fe1ad1558041~c4z-SEM_N3074830748epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1629427028;
 bh=772SFlU0Bn5D7rgfArVhhAXzPV/9tLgQ/gPex3X88rk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pAfLPXluBGbsKKPwrIshcqgVA3m9dKlSZDp6TFooufTf2RvhXKR3Es0XBev4CS+y2
 oPK/EgSI+J1tYwyeYftXA12T3KsgumacAVjEm8Ts7Rt/eZu/rA5Dl5JwYkz432CzEu
 jsyCKVreHraDZq87B45AGkrD9W/a+/kZ2hT6jX0I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210820023707epcas5p2061db9dccb7bfb2431c01663ee771ef0~c4z_xi0Ad2381523815epcas5p2_;
 Fri, 20 Aug 2021 02:37:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4GrQkw5S1mz4x9Px; Fri, 20 Aug
 2021 02:36:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DC.74.41701.6451F116; Fri, 20 Aug 2021 11:36:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210819171636epcas5p1d4f314b2e976a1beff2c39aed227b7c3~cxKlDVN9t2882728827epcas5p1W;
 Thu, 19 Aug 2021 17:16:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210819171636epsmtrp2e0bd9f627affba2d246e2c9f96aea7b4~cxKlCURCC1510115101epsmtrp2y;
 Thu, 19 Aug 2021 17:16:36 +0000 (GMT)
X-AuditID: b6c32a4b-0abff7000001a2e5-a2-611f1546590a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.96.32548.4F19E116; Fri, 20 Aug 2021 02:16:36 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210819171632epsmtip22b32abbc2a456cf12ec0afb6b17e6038~cxKhJLxV-1420314203epsmtip2b;
 Thu, 19 Aug 2021 17:16:32 +0000 (GMT)
Date: Thu, 19 Aug 2021 22:04:11 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier.gonz@samsung.com, mohit.kap@samsung.com, d.palani@samsung.com,
 prakash.v@samsung.com, jg123.choi@samsung.com, u.kishore@samsung.com,
 arun.kka@samsung.com
Subject: Re: [RFC PATCH: v3 1/2] add mi device in qemu
Message-ID: <20210819163411.GB32433@test.sa.corp.samsungelectronics.net>
MIME-Version: 1.0
In-Reply-To: <YRyiH7aLzBh/Cko5@apples.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmlq6bqHyiwbkGEYs59y0s3n59wGZx
 Zf95Rov9B7+xWjy+85ndYul8fYuTjXtYLSYdusZoseRiqsX8ZU/ZLda8ULaYd0vZ4sqURcwW
 s961s1kc793BYvF60n9Wi5vNT9kcBD1+nGtn8zi34zy7x6ZVnWwem5fUezy5tpnJ4/2+q2we
 fVtWMQawR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
 5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQw
 MDIFKkzIzni34TJbwTmxikc9+5kbGOcJdjFyckgImEg86/rN3sXIxSEksJtRYvW2hcwQzidG
 iYvnNrJBOJ8ZJbrOLWKFafmzcTtUYhejxJ3Fi5kgnEYmiTtPNzGCVLEIqEr8WvkMaBYHB5uA
 kcT3VluQsIiAisTTf3tZQOqZBd4zSbR+aWYCSQgLmEms6LrGDlLPK+AhsWmDPEiYV0BQ4uTM
 JywgNifQmK9vL4CViwLNmXJyG9gREgIXOCRaVrcyQlznItG1dwEThC0s8er4FnYIW0ri87u9
 UA3NjBL7vlxhgXAmMEpMmf8OqsNe4uKev2A2s0CGxOs9HVA/y0pMPbUOKs4n0fv7CVQ9r8SO
 eTC2qsTjCwfZIGxpidkrPzGBfCMB9M2tO5ogYSGBQ4wS23eITmCUn4XkuVlItkHYVhKdH5qA
 bA4gW1pi+T8OCFNTYv0u/QWMrKsYJVMLinPTU4tNC4zzUsvhMZ6cn7uJEZy6tbx3MD568EHv
 ECMTByPQVg5mJRFeVT75RCHelMTKqtSi/Pii0pzU4kOMpsC4msgsJZqcD8weeSXxhiaWBiZm
 ZmYmlsZmhkrivLqvZBKFBNITS1KzU1MLUotg+pg4OKUamHh5zb82x5k23eick/Fj5wxz1c8M
 HsXqoj4b9zgvkFXe3zUzQ6AxsMK5y2VC+4f13Zdq+ySOFF5YeWxJxsZFHvw7mANlV9i2x6al
 rjrX+TTNd1aTTqRy+GLbwpTq99qafCdrLl1cp9t+fsuiOEO96gtOt7bwlqcdXrkgbTFv7M+W
 K9pbwoWSf/QsPM1z++vPeR6pFzvDq89dqY+MYf/0X+3GqWVMm5ovGbPsyV6/fU7JMvFir2nN
 7Yrxb2+edTwwS+3Uw2T+/97KHvvjZvpaxQZ7/U5d3b8t5brjj939OcxaLJNPSd08tubi+nR2
 EYWwmt1KL5WW31/9fHnYN7PX3A8vZi69DTTReH/GtI7XSizFGYmGWsxFxYkACGlI7GYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO6XiXKJBmc/C1vMuW9h8fbrAzaL
 K/vPM1rsP/iN1eLxnc/sFkvn61ucbNzDajHp0DVGiyUXUy3mL3vKbrHmhbLFvFvKFlemLGK2
 mPWunc3ieO8OFovXk/6zWtxsfsrmIOjx41w7m8e5HefZPTat6mTz2Lyk3uPJtc1MHu/3XWXz
 6NuyijGAPYrLJiU1J7MstUjfLoErY9fSvSwFDSIVG28sZmlgfMXXxcjJISFgIvFn43a2LkYu
 DiGBHYwSH1b1MkEkpCX2PbzOAmELS6z895wdoug/o8S7bbvYQRIsAqoSv1Y+Y+5i5OBgEzCS
 +N5qCxIWEVCRePpvLwtIPbPAeyaJGfvngdULC5hJrOi6xg5SzyvgIbFpgzzEzEOMEo0dy5hB
 angFBCVOznwCtpgZqH7e5odg85mBDlr+jwMkzAm06uvbC2B3igLtmnJyG9sERsFZSLpnIeme
 hdC9gJF5FaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcMRpae1g3LPqg94hRiYORqDT
 OJiVRHiP/ZFNFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNT
 qoEppFza49fsT6v9DjSaVOinBMzh2FYg+LJP63/IZhHNz3yva6LXF53cFsKjFDX9o0yXgGKz
 ov1vl3VipuxH7oq9jO6N8hI+5s8gcXsuY3i3TYmKfMW3I9svCuWskn6158+h3kv3luS/TBOs
 uCz+51uP1Es/u8TcM56P18/7cPLZXplkmXUt8gu7Z1vF7zq2QPD61vk3LjydVvZgWV9lxnd9
 00Ov1K9Jdmj8Nm156/60+5ttheHCHxaedvzJB7SLjs6K/pbTpTuX17pcYstyz2+XJf4cZP3B
 dCT8I6dQ6pmMx5kR6zvMZb8XHBPY/eBeb/KX0KyKuwpd8q5vz+w942x5+vi8esuUUwmvLBU3
 qbUosRRnJBpqMRcVJwIAIIUHvicDAAA=
X-CMS-MailID: 20210819171636epcas5p1d4f314b2e976a1beff2c39aed227b7c3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----BPyR4Tz2JvO_1Z3EIRp6YQRj0IgbPvNniido9NqUhbSkaY-S=_74c54_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6
References: <CGME20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6@epcas5p1.samsung.com>
 <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
 <YRyiH7aLzBh/Cko5@apples.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_193715_615022_835B3F0E 
X-CRM114-Status: GOOD (  22.11  )
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

------BPyR4Tz2JvO_1Z3EIRp6YQRj0IgbPvNniido9NqUhbSkaY-S=_74c54_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Aug 18, 2021 at 08:01:03AM +0200, Klaus Jensen wrote:
>On Aug  3 12:54, Padmakar Kalghatgi wrote:
>> From: padmakar <p.kalghatgi@samsung.com>
>>
>> This patch contains the implementation of certain commands
>> of nvme-mi specification.The MI commands are useful to
>> manage/configure/monitor the device.Eventhough the MI commands
>> can be sent via the inband NVMe-MI send/recieve commands, the idea
>> here is to emulate the sideband interface for MI.
>>
>> The changes here includes the interface for i2c/smbus
>> for nvme-mi protocol. We have used i2c address of 0x15
>> using which the guest VM can send and recieve the nvme-mi
>> commands. Since the nvme-mi device uses the I2C_SLAVE as
>> parent, we have used the send and recieve callbacks by
>> which the nvme-mi device will get the required notification.
>> With the callback approach, we have eliminated the use of
>> threads.
>>
>> One needs to specify the following command in the launch to
>> specify the nvme-mi device, link to nvme and assign the i2c address.
>> <-device nvme-mi,nvme=nvme0,address=0x15>
>>
>> This module makes use of the NvmeCtrl structure of the nvme module,
>> to fetch relevant information of the nvme device which are used in
>> some of the mi commands. Eventhough certain commands might require
>> modification to the nvme module, currently we have currently refrained
>> from making changes to the nvme module.
>>
>> cmd-name                              cmd-type
>> *************************************************
>> read nvme-mi ds                        nvme-mi
>> configuration set                      nvme-mi
>> configuration get                      nvme-mi
>> vpd read                               nvme-mi
>> vpd write                              nvme-mi
>> controller Health Staus Poll           nvme-mi
>> nvme subsystem health status poll      nvme-mi
>> identify                               nvme-admin
>> get log page                           nvme-admin
>> get features                           nvme-admin
>>
>> Signed-off-by: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
>> Reviewed-by: Klaus Birkelund Jensen <k.jensen@samsung.com>
>> Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>
>>
>
>My Reviewed-by here was added by mistake. I've not given it my formal
>R-b, but I'll provide a proper review on-list ASAP.
>
>But just glossing over it, I like this approach a lot better than v1
>(vsock).

Apologies for the mistake. Looking forward for the feedback on the i2c
implementation.

------BPyR4Tz2JvO_1Z3EIRp6YQRj0IgbPvNniido9NqUhbSkaY-S=_74c54_
Content-Type: text/plain; charset="utf-8"


------BPyR4Tz2JvO_1Z3EIRp6YQRj0IgbPvNniido9NqUhbSkaY-S=_74c54_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------BPyR4Tz2JvO_1Z3EIRp6YQRj0IgbPvNniido9NqUhbSkaY-S=_74c54_--

