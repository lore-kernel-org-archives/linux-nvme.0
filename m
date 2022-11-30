Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8695C4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aq/UYI00/ffjoBL9PaJNSUdtUCR9jlm4b1V5qao67fs=; b=m7bVlz/X+F8GG9QUE3zfxnUDUj
	/PD2UcinM6eRPOF/dZJ7COcKdq4P/1/62PbbE1c1k9kcpFVoHNzxuFDlv4Gjh/QaUNDQpPSlV4/AI
	hPQBbqakKdOJ/XnNFDw9wyPvHcFlJFSpK+NTd3QCROhue0j4Nw5J5pEWYakhNwEUAKm5aKtgGakbO
	Ta6fpdyk+hunmXEQCbjU+WdiJ9YRXsK8NLKRhFqPBVu03BHJESAt2NbhE7X+ab1zVQATTE483oMml
	aZsXcC37tREjfjRVUbjxOoi0fr4O0DoIFpgESEEPVjRxD7PJEQGBx3bM7KczW2LtiijdD2QYryBCH
	xRtpBmbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TVg-002Lmn-2x; Wed, 30 Nov 2022 20:16:48 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TVd-002LjK-7C
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 20:16:46 +0000
Received: by mail-ed1-x52d.google.com with SMTP id x2so25604093edd.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq/UYI00/ffjoBL9PaJNSUdtUCR9jlm4b1V5qao67fs=;
        b=BMpZ/+ahITbmRX80lLP8Ro5ASLEpg8kST7kxK2DcULOB6x4/LgDzP3JQN6NkHmF46Q
         AAj2UoGrBV8K8/0WHw5MiobIj4EAi+AN2xEYMo0smVBi8pnOaPh0ybLGu1rsQfmCnSSl
         7VuiW3//h7M+unBLTHO9ya2lf2PerYsNslO/AYqRNPUiA+LiIkokQrLeDp1zbCQAfTFm
         qnFxzRg7opqWwM/kU7mjoch4NXZM3qknFul/unnhI+U4wbk7dAPB+KiuifJ47+fhNNwr
         3eZT+CZkHk4sEkwFW4CiXsyi8KGGcy5t+KanGAHXelu9hd71jUs+6ViH0YC99Oz2rwmH
         AknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq/UYI00/ffjoBL9PaJNSUdtUCR9jlm4b1V5qao67fs=;
        b=DZAALKiOwW4AoZ6muaCJx/iMHBAV57X5ei9/6bGG3Sf8ViMxVJAkFAtrapCYMKKQ9K
         ETJsq6X7IzUlE8/HyMJ1xq9gDtVN5nxXhJWxV/F6UnSuB3lKLtOqHLxyzROV4vlyQseK
         oWdX1Q3Hrg1SOaqv1or80wjnDnKAskfCGdjcRjmZyPV58MFP+Fl2Ks0Dl+FNIoJQOXla
         +HwD1Uk3PaDoEJAuS5cyWTm+tryhVfvCYpzy0ZdwbGHkKjKYyHRD5yHHAGRYFg2JfBxQ
         ssv6JLnGx3EbCuvMqoPp6XG5HO8ydWQzjPQqnJ3NayVm/UhLTJ44xmDwu4jS3iKUuza7
         fR4w==
X-Gm-Message-State: ANoB5pmFvGkiGLkifc9tIRFdrZTVvDIjwxHZiM2F80XN29OsCFdWoQMh
	61EkJxOj8wd4UH4Oc+KQZt4pmPXbnuAGSsj82xxUEqyGbN3dDA==
X-Google-Smtp-Source: AA0mqf6liYaZaUTMMrPRNlKEUeo2ZWFvKHNcUicbyeOA9sQ+wFWGK1t4Wg3ij7ItADzDgrx7moDh/Jy4IfDdayjdv7Y=
X-Received: by 2002:aa7:c042:0:b0:462:2f5a:8618 with SMTP id
 k2-20020aa7c042000000b004622f5a8618mr57571181edo.42.1669839401525; Wed, 30
 Nov 2022 12:16:41 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?0JjQs9C+0YDRjCDQkdGA0LjQutC60LXQu9GM?= <igor.brikkel@gmail.com>
Date: Wed, 30 Nov 2022 23:16:30 +0300
Message-ID: <CABPTj+oWpSHaD_N+Xhbu1QiRqsH91wnbGtw-YB5qWfH5gQB92g@mail.gmail.com>
Subject: Bug report 216049 duplicate IDs
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_121645_358367_A7567DCD 
X-CRM114-Status: UNSURE (   4.84  )
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

Hello!
I have same bug "Bug 216049 - Unable to boot system, won't mount
because of missing partitions because of "nvme nvme1: globally
duplicate IDs for nsid 1""

I created small fix
repo linux commit 8995973d488959560c7b610fe9d303cc6a242ce4

Text version
repo linux
in file drivers/nvme/host/pci.c
add
in rows 3526 and 3527
{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
.driver_data = NVME_QUIRK_BOGUS_NID, },

--
Brikkel Igor

