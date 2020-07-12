Return-Path: <SRS0=FSy1=AX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F0C433E3
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2020 09:32:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CD52072D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2020 09:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1MEHPrwr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XpPTH4hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD52072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-Reply-To:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=2JAThCUNn/1PPmcgl4FBYME4eIzbznfo1JtCUjhV/uY=; b=1MEHPrwr0SU9UUGER6eU78Qcs
	Qgx1cTatS6SIe1FuXxyFuewkYnMrAlcBP5xru/wX7v3qBwvxSyOcFz/uQiDSzZDEHY0B6taxQ4rpU
	R7tC9owPKXhfu2NCQcwO1ouw4Lsf7ygkDOdu3mNgetvMd2tRPOtsyN0D/4c8/dNf8Csa+6EeR4bI0
	Rrle53/kGpobyl7qofa7a6eCGsTKhJ82VkL3g5C3NFA67h5JozERqB7BZOx96NK8eiLwEPNka9U+4
	zM0VfyHju5ptYJTMLMpafPu6G9ARQ7oTJ1qp3htOmq4EnBz+kds7DC8Y7FvQFGkDpXK8rXzV5i/wS
	YReuPOBew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juYKy-0002Ci-1i; Sun, 12 Jul 2020 09:31:56 +0000
Received: from mout.web.de ([212.227.17.11])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juYKu-0002CB-FG
 for linux-nvme@lists.infradead.org; Sun, 12 Jul 2020 09:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594546296;
 bh=JtMHZ2uKQd90RBt11dvUAcYau0lsDequr09ki9jrZxQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:Date;
 b=XpPTH4hY00SALTei6tj/n1UuK9JesvthDSPYH1c95/1hc8TEpCP8PPeb5DPlcSxkG
 RmX/IeQub0d37uILx8qXjzzjohqN1T2oQ445alVvFpHWNL2Q3PNuRi3vbhVHNIwYZL
 1J9ZJY5/fRMQxTSk1nnJHLV3yh0urXd8p/wfM1jA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([80.132.91.99]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qav-1kohJq3mPd-00yut5; Sun, 12
 Jul 2020 11:31:36 +0200
From: Ingo Brunberg <ingo_brunberg@web.de>
To: "Rajashekar\, Revanth" <revanth.rajashekar@intel.com>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
In-Reply-To: <d163890a-a469-e71c-45b7-f63e1efee04e@intel.com>
 (revanth.rajashekar@intel.com)
Date: Sun, 12 Jul 2020 11:31:18 +0200
Message-ID: <m3k0z9nkpl.fsf@web.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:+O6/z1HUbaoQwsEArXtH09PoRdGQDx+eIKmj5J5E9xWoz2Jx/6R
 qjjjXNQ5GdVuCRP3iGMs1wqzDr7C6RMCtTE63ypznYQy4IXjnizlCD9m1LAEK+CRZoQRVGT
 InVAnSQPfM/bIgqJGFoX9F0FoQ2hL3tyuoZf90nw2CCu3W6NRAIsJN4DBXzzHCGcLgx2U1a
 1hlc1jelADz2Hi2YRLQMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+2VyO5Yexv8=:7vxyn9h2WibImXLOebFt9L
 tDhPYy84sjlChW1ZT22Qmf0E8qO7mLi/10BdaPNVpZ9DJ3lBvxX3k1tohC2nKXSAO0P+oicsb
 FfH7M6WW4/LKQj6gjOTe4f9smPMwHflqOx6B+CQkU8M7E0H16eXguTOnP6BLX6Rye03EmPLxa
 s+zK/f6xpCrFmPJNAmb4czhTqrMtbV8voZ3XK2ry2xX37yMAVk5QMzcMqWDqrt4UblfFK1zry
 1XpwhCVeZskSDtZ8s+xHKiQHjoWfAb7LwJVtYrYX0Ys+2W3ollJ0I6VtHuDT1VHqMEQzngW11
 EpULtCsFqgvtMoBSCgNf+uvdCvCJZLJmezndiekbHnSCgeZmKNQybP4vppZpYAYKCYOgw92NV
 aKH88O/QfttKPGmBhoJS5kiLceGhNixNqrWy6vEWq23xPRHAX/U85Zl0lG1oIwUwldlDtajOj
 yvy8cvbDc6OCtF+ejD8y9/gH7nhIEjM1aLC7WajzzrvHgqVpYoRxansFnRUvS/aktVsEQuXxx
 ZqVPTwgdvmTTx/9E2cIPt1yMbOwDaQ8kHFcllzQ2oeOZ5bdKueXEL4JZtLt9lPuyF27s2QvDN
 R1ojfl9Dv+bTFtzOwVA+YNh4goHro0Q5xPZM3Sv3sbo096bc75WIOmEjU4KBPrb3Z/7AUVdIq
 w1LZ/W9hfrvRwAqKmKr3jTtBU2uQ9Ccu9O8BqEWyazM0d9JBHDjDSVwqKc9szrSnayksAwUHD
 W77aR/j/giQt5IoLCfGiBiPLXmzKlBdzcAQmCF6uvgjqMvLhF1QmhK1dZCK+gSWFzi2nAq7xu
 Jq5G3Dheq+qN/TjdOKwDV9XeTM43Miy0tIZNygpd5k3UDew/7Za31Q9PnQRgsKLp0bQzy4Cgl
 r0BaOlDDndRwAlc25SZLWhIw6CpG8e5oWgCP3EmipVXUyE8VHGCb741q4LxHRY+XwuNQ+e5w1
 6QuetibA1Ll5D+J68kF2CgXE589qyb5oXNkFwyumL5CKY/49cQNIKLY9u6Wno7FI9i+guoMP5
 qwpOphTyQIrI1hHx/MP0Je7nXvWEMn9VTRzHHW/JKaIoLAumixvKXLRN8voGkw9gO2ZAtgZwt
 f4PlWKhvQZOGiKRiRS+lTbWc2b/x4z3M64NvWkoWd3bQzkSu6Xry7F26tHN+TS7C4dPXeYrLD
 HTaG0guKE/fQcMTlsw6BMV6pGOhUpwMHWgz9z3+tj+YTof/qGtJN0DBTtlfzEH8pFr3ijeQZC
 4FqxO5VKocAwKmDM4lUmVYDQ/mabiKby6VJM8Fw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200712_053152_789900_F8122D82 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

"Rajashekar, Revanth" <revanth.rajashekar@intel.com> writes:

> Hi,
>
> On 7/10/2020 2:22 AM, Ingo Brunberg wrote:
>
>  With commit ea43d97, appearing now in kernel 5.7.8, you made my
>  cheap
> SSD disfunctional again. For reference, see bug 205679. Maybe you
> remember the discussion.
>
> Shouldn't the logic used in commit ea43d97, be applied to the line 'if (ret == -ENOMEM || (ret > 0 &&
> !(ret & NVME_SC_DNR)))' in function '_nvme_revalidate_disk' ?

I was wondering the same. But that does not make my drive
work. Something about that logic is not quite right. If the condition is
met in nvme_identify_ns_descs, 0 is returned. So there is no point in
repeating the same test in nvme_revalidate_disk as that code path is not
reached anyway.

If I got it right, NVME_SC_DNR is not set for my drive, so this test is
not the right solution for that problematic controller.

Regards
Ingo Brunberg

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
