Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2356D2594F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8K189jpO9M+zQqcOwAP1sKwikRj3TWyrARwywPnfVA=; b=wqwD3GFvdmt+pkszIULJNEh5g9
	Wk4UMjtjwNt3AWKGst5XhVQ0YzgG0MW/NZghydy3HVP+oiDyL6R/CU5QD8stn3xLDYDXp3yiDIbko
	p7IE7slRZI1rJ/rG6/mxVX9ChtRTert6bN4fVbLjltAqB12vKbHMXVM2lrdOWcQHjiNMX0cLf9i86
	a+aIAjdqhOJrxYmlwd/iTB34Hl7/S6wzslAHbCQIXkmJx38r5PUn2YrQTAaYrWFILB+oryFzb61Ao
	msHsHgkXc5D3ZqVRwysAN5kUGPwbQSpdknS+WWUT+KQnbRkJAzNR9v+j+DMSOgRxJHGYvTiLir3bQ
	j+xbGpyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkpG-0000000EWcl-0bhe;
	Tue, 27 Jan 2026 15:17:54 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkpD-0000000EWbQ-3DFC
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 15:17:53 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 30fbaf2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 16:17:49 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 16:17:49 +0100
Message-Id: <DFZGZT9C3D6B.346BT9Y4IGVFB@bsdbackstore.eu>
Cc: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <gregkh@linuxfoundation.org>, <security@kernel.org>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>
Subject: Re: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "YunJe Shin"
 <yjshin0438@gmail.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
 <20260126064248.591202-1-ioerts@kookmin.ac.kr>
 <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
 <DFZG4OIFIHO8.313E3KOTXSDL5@bsdbackstore.eu>
In-Reply-To: <DFZG4OIFIHO8.313E3KOTXSDL5@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_071752_153965_5BAFC1AE 
X-CRM114-Status: UNSURE (   7.11  )
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

On Tue Jan 27, 2026 at 3:37 PM CET, Maurizio Lombardi wrote:
>
> Nevermind, now I get what you mean: you can hit the bug if you send
> H2CData after ICReq but before the execution
> of the connect command.

I was able to reproduce the crash:

[25362.399746] BUG: kernel NULL pointer dereference, address: 0000000000000=
00c
[25362.403368] #PF: supervisor read access in kernel mode
[25362.405451] #PF: error_code(0x0000) - not-present page

[...]

[25362.430592] Call Trace:
[25362.430945]  <TASK>
[25362.431250]  ? show_trace_log_lvl+0x1b0/0x2f0
[25362.431910]  ? show_trace_log_lvl+0x1b0/0x2f0
[25362.432507]  ? nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
[25362.433285]  ? __die_body.cold+0x8/0x12
[25362.433810]  ? page_fault_oops+0x148/0x160
[25362.434388]  ? exc_page_fault+0x73/0x160
[25362.434953]  ? asm_exc_page_fault+0x26/0x30
[25362.435573]  ? nvmet_tcp_build_pdu_iovec+0x4c/0xc0 [nvmet_tcp]
[25362.436357]  nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
[25362.437113]  nvmet_tcp_try_recv_pdu+0x1ef/0x2d0 [nvmet_tcp]
[25362.437856]  ? sched_balance_update_blocked_averages+0xdd/0x1a0
[25362.438672]  nvmet_tcp_io_work+0x70/0x8c0 [nvmet_tcp]

But it appears to have been already been fixed by commit 32b63acd78f577b332=
d976aa06b56e70d054cbba
(nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec)

dmesg output target-side:

[   54.436869] nvmet_tcp: queue 0: H2CData PDU received for invalid command=
 state (ttag 43981)


Maurizio

