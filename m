Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA0C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:45:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DA661455
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA661455
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lp4tyZzGZdDAvwCk7mG8Z3iHkhJ0zAm3w6+PO/v9QRE=; b=TSr1W/kVwwY+5fE4bCnLtBUyXi
	2c05afuEkzvyiXX5bYLA1+s8L8c9Eh3nUHzTNpsiOJQCj5Y/3yTL6oast7Oue9oQNmk4RHNF1Cbkl
	WWnAJmEUGj8VuXvVGekvYfDepP8uAKx9peGu7in9PEeM89p29urfj+W/WWFy3n7u/4l9Ky1Hzm+9w
	ewvFGN6fxi+Rv2TEjfqbhGTDT1sFPA2uXCHXm1A7vsR2cljBnRsE6idv/sN4OiMGXnVlzebe87vHA
	r3yd5ZbNJBKorl+ykcvo54yCTZ4AtY9FDk+7fjXgkRM5cBWfqDhwpnBEB5z3V3gXn+js1q4p2DMaE
	3lFjB6Zw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbvjT-004dvr-Lh; Thu, 29 Apr 2021 01:44:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvjG-004dtV-GI
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 01:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619660659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=HEOLXiA1Zmaio92bpntVPVTT8CY9WaQ/k2Q4uX7fuqI=;
 b=IdjRJxtCJqV/IwXKEnYxVn5izKo1TX9rXbjKqhb6HyRM51wskBJoXVJ5Bxw7pM3/x/ExgN
 zWIghKB4lKPapCOrLK6AWXCrXXNzRYVnQ2Qzoef4K+UvorEU2NuJCjtL1zwtf1pMwJ1hJp
 Y7Srj1BHCPE7uD/LrMcQFFjOxIcsNFo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619660668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=HEOLXiA1Zmaio92bpntVPVTT8CY9WaQ/k2Q4uX7fuqI=;
 b=XddBE04fKq5eKJ5frcI0YsbC3MNes4J9b95J3F0slbjlk1o9KN/Y+XnWHR2Fyzpuw2G9Kv
 3Iv9a+Dmo9OzyQYp6Fy8Z1ebaQQaX+Htjhom9LWArrh9WZp1GIgBfv8eBaRWZQ66n7wOFJ
 ZW0MU8zPybhiEKR6qJEuDC5Mg2DqHj4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-W9RdoectOSaB2STHo-YAQA-1; Wed, 28 Apr 2021 21:44:17 -0400
X-MC-Unique: W9RdoectOSaB2STHo-YAQA-1
Received: by mail-yb1-f197.google.com with SMTP id
 u3-20020a2509430000b02904e7f1a30cffso44031486ybm.8
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 18:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=HEOLXiA1Zmaio92bpntVPVTT8CY9WaQ/k2Q4uX7fuqI=;
 b=TRi2jPMXWOiIt/ebKeRBBWdYAgZenrKDZi6DuVoJ6VLmSYzuOUqOkX6zREX5NVvE93
 eiu7SeEzMk8cW1rsXfRz8BjIAeFAKDN7Gdnt16y78QYou3THwc/FzEOPzF5xIO5bPEqB
 3z/w21av3nqkLLxIU6BuZ93AVlnKhsbutBbD//skHNqpPKet2rIEDEUa/RKbfHBeCLeO
 IMfovu3mi0ETllmkyL61EeP37Ggnvtt3S12neBfZ0UZ2nH7zofWo4ftyMnoGCvVPpne3
 lFfGQNSxZj10MRBcX7l99a8Dlqxdc8yT19JewpVuemJmtEN0hl5As7LBBsbtPA7tTrNC
 5/kw==
X-Gm-Message-State: AOAM531E/LtPZjYPofeKV6C+epuoCtJv9LTIqoFFNn4Zno5KqwFu/6Ys
 L8trtC22qo+IXfNBUY/3U/VOzBDAHkcrYbjhdubCjbkPY2sFpkKExXjAd9GFKywJbTzXzdJ4P3/
 GQEh2WG9vcr+qZh6fBUrLNSzGcE1mrU4WN3U0PP+xvaQ=
X-Received: by 2002:a25:d650:: with SMTP id n77mr23114416ybg.133.1619660656903; 
 Wed, 28 Apr 2021 18:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvf9jIxnwLC3hGf1PvltkNNJqig4W3XKcpyRs8dFZQWOvvpaiy9NS3ncVAtSgt3EvJoJtpkskcV/b2ewyXGuQ=
X-Received: by 2002:a25:d650:: with SMTP id n77mr23114398ybg.133.1619660656702; 
 Wed, 28 Apr 2021 18:44:16 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 29 Apr 2021 09:44:05 +0800
Message-ID: <CAHj4cs9o9+CkkZk3JUrgr=-D+ExBYdzLFxwD2fJ+_NxkvGyD4Q@mail.gmail.com>
Subject: [bug report]unhandled identify cns 6 on qid 0
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_024438_431220_282E2A00 
X-CRM114-Status: UNSURE (   5.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith
I found this error log during blktests[2] on linux-block/for-next, it
was introduced with [1] and seems no handler for NVME_ID_CNS_CS_CTRL,
could you help check it?

[1]
commit 5befc7c26e5a98cd49789fb1beb52c62bd472dba
Author: Keith Busch <kbusch@kernel.org>
Date:   Wed Mar 24 16:18:05 2021 -0700

    nvme: implement non-mdts command limits


+       c.identify.cns = NVME_ID_CNS_CS_CTRL;

static void nvmet_execute_identify(struct nvmet_req *req)
{
        if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
                return;

        switch (req->cmd->identify.cns) {
        case NVME_ID_CNS_NS:
                return nvmet_execute_identify_ns(req);
        case NVME_ID_CNS_CTRL:
                return nvmet_execute_identify_ctrl(req);
        case NVME_ID_CNS_NS_ACTIVE_LIST:
                return nvmet_execute_identify_nslist(req);
        case NVME_ID_CNS_NS_DESC_LIST:
                return nvmet_execute_identify_desclist(req);
        }

        pr_err("unhandled identify cns %d on qid %d\n",
               req->cmd->identify.cns, req->sq->qid);

[2]
#./check nvme/010
[  493.632730] run blktests nvme/010 at 2021-04-28 04:19:28
[  493.669330] loop0: detected capacity change from 0 to 2097152
[  493.685798] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  493.689397] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:48741e3a-3c7e-428b-877f-b78897ab0f61.
[  493.689439] nvmet: unhandled identify cns 6 on qid 0
[  493.694412] nvme nvme0: creating 32 I/O queues.
[  493.695351] nvme nvme0: new ctrl: "blktests-subsystem-1"
[  497.870910] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

Thanks
Yi


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
