Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33063C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 22:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qEQBoPxTdCAMRkXG290tkHQ+aovb+g9+1rHpk1yAYHk=; b=E5xFXSW4Z99uxkkp1genGAOdaH
	nHgQSglz+hWzgL9siS22r8XMAjc3AVj6QJjvjcMn8OTqeEFDecYbl/5eH9/7IToTwsqORR3RZTPpH
	mUeFxi62OVA2cALWNyNg+/sbn8wG5CrDJUayIq4Tj7TKt8AMtldN5BJX7BVQN3srU8cVeACEMExy7
	oTM1U1U0z27WnPMZvTmxXhIRhWQym3EbYU3aavaACz3SEOpktawAcHTske3/sAqv7jRKqdyVM4aVM
	6PfX7pMQX1zyUxL5/Bc19YUni1bIN8qVz2lySnq3xzxc7fyMgNTcFrplbsu8j6mfUHXuRy9QTE00Z
	g6FZhnwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWQkr-009HhX-RR; Mon, 21 Mar 2022 22:44:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWQko-009Hg4-5i
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 22:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647902635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qEQBoPxTdCAMRkXG290tkHQ+aovb+g9+1rHpk1yAYHk=;
 b=GA2doKyolWZndVGhdCdemWNMI/RJYjeUDMgRxzkYnBb4aV/1iuf/x0XJpQli7MLdxZusJK
 28i2anXVsGhz/HExTiV3q6Khy/brFPfpsrnbqYJdDD8oYsO2L1BUhMFFK/9DwrNfRgodDA
 +ZMlNLQWxeQ9gpb1h7thdPyylXOljRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-vGsEa8CfPVC70FVzIRDc2w-1; Mon, 21 Mar 2022 18:43:52 -0400
X-MC-Unique: vGsEa8CfPVC70FVzIRDc2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FA48185A7B2;
 Mon, 21 Mar 2022 22:43:51 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B827140242B;
 Mon, 21 Mar 2022 22:43:50 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: lengchao@huawei.com, dwagner@suse.de, hare@suse.de, mlombard@redhat.com,
 jmeneghi@redhat.com
Subject: nvme-multipath: round-robin infinite looping
Date: Mon, 21 Mar 2022 15:43:01 -0700
Message-Id: <20220321224304.955072-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_154358_331163_20C9EB25 
X-CRM114-Status: GOOD (  14.38  )
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

I've been looking at a lockup reported by a partner doing nvme-tcp
testing, and I believe there's an issue between nvme_ns_remove and
nvme_round_robin_path that can result in infinite looping.

It seems like the same concern that was raised by Chao Leng in this
thread: https://lore.kernel.org/all/bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com/

The ordering of nvme_ns_remove is constructed to prevent races that
would re-assign a namespace being removed to the current_path cache.
That leaves a period where a namespace in current_path is not in the
path sibling list.  But nvme_round_robin_path makes the assumption that
the "old" ns taken from current_path is always on the list, and the odd
list traversal with nvme_next_ns isn't safe with an RCU list that can
change while it's being read.

I'm not convinced that there is a way to meet all of these assumptions
only looking at the list and current_path. I think it can be done if the
NVME_NS_READY flag is taken into account, but possibly needing an
additional synchronization point.

I'm following this email with details from a kdump analysis that shows
this happening, with a current_path entry partially removed from the
list (pointing into the list, but not on it, as list_del_rcu does) and a
CPU stuck in the inner loop of nvme_round_robin_path.

And then a couple of suggestions, for trying to fix this in
nvme_ns_remove as well as an easy backstop for nvme_round_robin_path
that would prevent endless looping without fixing the race.  

Just looking for discussion on these right now, we're working on getting
them tested.

- Chris


