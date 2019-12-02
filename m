Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14921C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 09:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926AC2070B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tA6mtDSp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="S4tKtJem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926AC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oI7GsOYsuh0gWLXX36LC4UDj/6MLYkxm4uaMhCeRxdA=; b=tA6mtDSp6DNaW2
	/s92TQuDjjP1+CNq2rL0xiyOF8a+43wsCDIIzTEcWgn6324QX6T61Jx8xusdPOZHxFLnyEUpyN4ZQ
	0wuipDCDd6XsLPCWl2VZZVgKSMgqVSjY7z0W2HE/bZa9OrSBNtkC4MW107HvDAtr1Coq5JPaQi+nk
	GrVDKMAiaF2X1g5Ob7M/wSu7/eNsT2zFWRXTKUk/JLN/6k56RLvo3T2lhxVjD6L+GmbT6756pJdM0
	iQzOLxwwL2nmLulOD9DJavrXr4btPMjOH664rrlNk11Z3feIk9XboeebTUhrbR6Euf/vR0+5ZSLeq
	NRkIXXJvGFG8TMWCbY9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibi3S-0000ra-AZ; Mon, 02 Dec 2019 09:31:42 +0000
Received: from mout.web.de ([212.227.15.3])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibi3P-0000rB-H4
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 09:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575279093;
 bh=eicIUsDz1ioYIUhVOlX4k1U8ijlxNGLGY6/0jkLSSXU=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=S4tKtJemgISyVyBpBZq0pNqbgY2c5usjkqmH9wQAXyjy1Rrx+AyYT571KH4Nd03hV
 v0oKbeZgg4knH5XGv1FRjfwG8HK2iutf823rwOWXtkLBwBYTuaFCtwc20oYwWOun1o
 R7iuFhfWT94qUKurquwMLslX4A+BjPUMwTyRBBH8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([84.143.231.13]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqUan-1i71vg0RsH-00e0ch for
 <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2019 10:31:33 +0100
From: Ingo Brunberg <ingo_brunberg@web.de>
To: linux-nvme@lists.infradead.org
Subject: Regression: kernel 5.4 does not show NVME SSD
Date: Mon, 02 Dec 2019 10:31:18 +0100
Message-ID: <m3fti36pll.fsf@web.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Z2MUuu2y2r2pA9Pn5iEiF/TIJQjvENGcJoIABnCkuvce2TBM33p
 7q/ekZdWERGThwQ5SwpMAeaDCVcx/cEWE9Ap14zBjkcUc99sgjgWoGtItk/mquMp4Le6wTb
 FQ/AXUAsvMztdkYobW5VbMcIgs+/35VzVtSMUUta1S+Hosr2eVYnZZsVjMnJmekmO4INfFX
 oub5noFjHkSSgO++YfIyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/z3XEotjN4=:W/KwBt00JjKO9xdGUTFPF3
 MBZ5kZAKSxtTV8gAzVWcTAEQT5GTkyBfPfj+K9Bbm0ne9Y2CYLnZmFsSfguRr/m69nUWbJbLl
 aKtjYdKEqPRRgnR9hELUOPX6sJ513F8GUgoH2e3Ei6h1QMQdyVLOQi0+YAemYe8yZsrBuTgL+
 L7bvmEqTj6HhKfmzutLkEUYmQVMm2a6BNBCs+DoSPfNuN4+Y0ipE5LWfIr7jriB4ZGps1f6JR
 O42x+e9yI1r6w3ZB9Ba+n4pmpKdhyQVMnRaCcVNjWYUGHSqKj/sHTbSJLqSk3bi+6STkFmzkC
 ByVZfeTtGWadibNatGfiFFzB3x2opJAIWQ4kjj8R3sJT2vQJYWNeFZguztQ1Uw1aB0jKKd03G
 E2387ZLhieNdHoN7vlWfGNgo9E61nKxv2n0Mj470UsE0kMZFRv/RFLB1/XeEh2Nwe4W00GiIy
 VkPAJGwzQPzXrYP/s3j7t1bbs7ozpSCsoqK/lWRWUnsFE40K011l+RngT2xsjZZAiPzvbHUZm
 BuhatmdebYeR8ZCLA+zOpNz8tfLJp1YKlhdRVd4E2zm4vjzOfgm2dFhAaWz3jbocndS3PON73
 Xo0UkRmEHyvHiM/v84RkF5FnJxWad2h7Buezppcjy1V2AhcSFTngDwNYFgueX+q47aBnZc5oh
 /UgywLymwKKFEHuABlYx0yV13vNd5dGsP86StzxwTHM/KCRxA/hsBxpc+U1BlXPWx0rfiRnBf
 tYzGQM4ZsdDYQ8dnM9m5DCJEV5NlrWib9gm47Iz78tlIM+OdnT4dboJrAOoNTE53TgBOs/K78
 iJ3h2mVaxink3xbqvH7h6QAh0jIG+kz/E24vVx7U9NMnF1VIoZgiheR076MtHAWBHa7Qkun/n
 EY+75kMw3apI2vN/Lxi0NvAxdea4Lflro9ROc2Q2eVDMOcoIPS6LJfChbdZ0R1DdGgxiOe4hu
 AQdr5hDcBuIK6InxlwYEnzHMi+48If57GrCDeHtEH3jbt5T1qiKDqU+HgAGsxP5fg17/aB+/A
 QZwJINzzc8HaB2eTHQGFHfuV3YEv4szLFoHcs9iYY3W1R5ZUgOnWsaqQOtJV8m3EWxkK4wwu7
 UuidTLlNFfZgQTg2HtxtshkzMq9mcLoH3+HOvLnURhBlM9R5qbVPLaKiRoECiJkHn1VI4DPDh
 D0OJ8rB4XhUtA1C2XOcyLfhQNLzr5vC/TsPa0ryTD3+zOYGXuFdAzbFNbMbuXtbFN+UY7BbR9
 9idQkpfILJ8t0mSFBSP9ND2mxvtkLsPraZvVooA5AiNRJsK4uSPXl68+x4Og=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_013139_903148_A8BF28DE 
X-CRM114-Status: UNSURE (   3.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi experts,

starting with linux kernel 5.4 my NVME SSD from HP is no longer detected
correctly, nvme list shows no result. I made no relevant changes
regarding .config between kernels 5.3 and 5.4.

Please have a look at this bugzilla entry:
https://bugzilla.kernel.org/show_bug.cgi?id=205679

Maybe all SSDs with a Silicon Motion 2263 controller are affected.
If you need more information, please ask.

Regards
Ingo Brunberg

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
