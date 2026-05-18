Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1ECD4F4A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u8+qzU0W1zzwMpcEaXSpQvWhLzK3bb5pvFaLvwTKH2A=; b=cX9ovbKGUCkYPOTfNi72sqWofl
	RF/6JJb/Lcq0pp0NKAiKNUDwTh+Qk+Jfocd51yUusVJc6tcr03E+EeDBHemHDzqbhoWAew11nR2BM
	XTvFKrFQw7Izwf4umzSrT2UuOhWxCqhNfe8kUEfcF3RbTz6ASLfyBJZFr09pcCSkA2hKmjaa2Uhtp
	ifmGy7D6UIK6IqH/oMvfPLegtTpqpgHE7XjHJdFUSlOZn6PEhhpbnaRnPGAtccR7/esf4aPqpti+r
	9Cg5hV3bFtZxHP26I3UVszMlbaS1Jtpxog44TB9zm9mSa8QlW2p/vOEE/8Pvq1U/AJU0T28zZuiLt
	l6KLCfSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyfL-0000000FvTt-1t7J;
	Mon, 18 May 2026 14:09:55 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyfI-0000000FvRq-3QhG
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 14:09:53 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-50fb8e9a4edso32652641cf.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779113391; x=1779718191; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8+qzU0W1zzwMpcEaXSpQvWhLzK3bb5pvFaLvwTKH2A=;
        b=oriei/wV6pZT1IAWqc0+RsYDZOhzfS0dnPTzbC/WYFFYgFq6iX9eSVu1no4HJ6m/R7
         PEnzKMqM1AUJnqxhHJ7ryH1kBHGskBstM4M7b1wq8KC2P+65PFwxMMYpJnkZxVQ5UDcn
         q/085un7anaOzrCaDaMKHutrfiwuBemgBLCuZj4F6NGm6zGZ4DWrAlPWJUkKWeCVQfRf
         jVk0Fyzgq7Lkk0A6f6lis3/gAqHLAESf0QiFp7HhUu0W/kpqT7OHMo50rDISnAJPoo/7
         Ah4qmyYg0KAgyN3vxkJlRxSssSqQ7rAEw8tZZ3ELZlvcdt+6FVk6eA46jPJHq62OUij4
         pu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113391; x=1779718191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8+qzU0W1zzwMpcEaXSpQvWhLzK3bb5pvFaLvwTKH2A=;
        b=k2Q/2wsmIR26BYBSUgNEnpa5tte6duml//LfCNVLTzRYC1bV0johfMh5LdCoyX+j33
         B3oePAZGBQ3Jph8wwe/tbLDgVWORscdA8AKrXJw4PQCxrnWZ2c28K0SA5Lof9QaWkZl0
         nyd65z9X4uolz/+HUb/wg5yJGKGPzoZrKFubdBblzEIdpJo0JMydUHoNJK6+puI1793j
         iVXxp/oXq0Xt8qiDDqNC15rmCguxYkdSfm4BJrqpddvujVmNIsYSbeNoJwDx3jEWdzak
         KlvWS0QVHX+JL6uiHQ6b+cq/HuzjRkPldXIm6VvK7pUlDdgB6OQqR+wlDb7SPuD/WjZT
         fYOg==
X-Forwarded-Encrypted: i=1; AFNElJ85tfkgy4+4kH7QzLN7XVVHX5Nzu0jZc+SoKuo3lvDo2VDmw1GMYfg/5z7ULUdyakZKjn7phdThgK7r@lists.infradead.org
X-Gm-Message-State: AOJu0YxgMK/YokDgZp91wiuQiD6nndkJ2BJ3IOGrTMWbm8m/azUF0TeQ
	mfSg/3xioyjB33Mk28VKbic1iPYGibWfJFbReiuvTXP9AoFlC0EPRv0a
X-Gm-Gg: Acq92OFMEEMYtgOSmYJleBJtT1Aj1XlBYBulsHvRPRSt2vFduSN0jRt4fTiGVaWRTQY
	MDsAaFjA0QohAYBnch1ET+4lTujQfZ3iUACrjz6lzMrNaNlpSQzn3MN9n134l9yH1knSJSdxFIV
	zFq++uMvg6gwWZ5AU82fo3RXnbRWqUA2mW3QXYuqofNTe40oa0UDd3CMRQBEmVUH0kQj9x+NS3C
	aYoAuT9glzE00C//jBy6AFlfpEe24DsXgqIEN589FNYZ+iSQlus3TyO8MNvV6jUug/roQ7BNk6d
	H17r1agjgjNjPH8ca6Qp+ca0VxgAiIYh1yCR/+DhLjjkQSsDbNxQD28uWLL5e+rmfiPjsuMCNeM
	rkNVl+Jr7+fZVDHPVZHu74yXGBBYVB9isk5ib08tPkvZ8Z6qq70RMvMQaAkmJEMY6YYZ34d8hSO
	YOV9ByUb+0UkxFoJZkg6XBcfLwSQkHGQ6bNFPxJUrbGc6i4DyJ7Eq/TBe1AwYUEwmuCXH/IH1h5
	0kmLyVlaulIr0FCyF4JpTJVLbh3y8grBvLrEYtNEYQ=
X-Received: by 2002:a05:622a:a1b:b0:516:4f76:aebc with SMTP id d75a77b69052e-5165a0072e8mr213950371cf.1.1779113391191;
        Mon, 18 May 2026 07:09:51 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm139477401cf.3.2026.05.18.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:09:50 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [DRAFT][PATCH] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Mon, 18 May 2026 10:09:44 -0400
Message-ID: <20260518140945.2751273-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Disclosure-Status: DO NOT SEND - patch and patch-discipline artifacts pending
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_070952_873563_E41689A3 
X-CRM114-Status: GOOD (  10.73  )
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

drivers/scsi/scsi_transport_fc.c::fc_fpin_li_stats_update() and
fc_fpin_peer_congn_stats_update() walk the on-wire pname_list[]
with a u8 loop counter against the 32-bit __be32 pname_count
field, and never bound pname_count by the descriptor body the
TLV walker already validated.

The two functions are reached on every host running lpfc or
qla2xxx as soon as the fabric controller (well-known S_ID
0xFFFFFD on an FC fabric) emits an FPIN ELS for that initiator;
no host-side capability is required, the fabric is the source.

A pname_count of 256 leaves the u8 condition i < 256 true for
every value i can take, so the walker never terminates: it
takes fc_host->rport_lock once per iteration via
fc_find_rport_by_wwpn() and never releases the calling thread.

Impact: a fabric-side FPIN sender (the elected fabric controller,
a co-tenant N_Port that spoofs S_ID 0xFFFFFD after FLOGI, or a
compromised switch supervisor) can hang the FC ELS receive
thread of an lpfc or qla2xxx initiator indefinitely by emitting
one FPIN ELS frame whose Link-Integrity or Peer-Congestion
descriptor sets pname_count to 256, blocking subsequent FPIN,
RSCN, and multipath-health processing on that HBA function
until reboot.

Switch i to u32 in both walkers and clamp pname_count against
the per-descriptor available bytes (desc_len minus the offset
of pname_list[]) before the loop.  This refuses a malformed
descriptor that claims more entries than its TLV body can hold,
and is the minimum scope that covers both walkers.

I reproduced this on a KASAN-enabled x86_64 mainline kernel at
f0db6484b6ea via an out-of-tree module that allocates a real
Scsi_Host through the FC transport API (fc_attach_transport(),
scsi_host_alloc(), scsi_add_host()), builds a 2096-byte FPIN
payload with pname_count == 256, and calls the exported
fc_host_fpin_rcv() from a kernel thread.  Without the patch, a
bounded watchdog timer fires three seconds into the call with
the kthread still inside fc_find_rport_by_wwpn() (offset
0x14b/0x2b0 in [scsi_transport_fc]) under
fc_host_fpin_rcv()+0x4e8.  The patched-kernel A/B run, the
legitimate pname_count <= 4 regression run, and the checkpatch
and get_maintainer outputs are pending the final patch draft
and will be captured before send.  A reproducer is available
off-list on request.

Two in-tree forwarders reach this code: lpfc passes the full
hardware-reported payload_len with no software clamp
(drivers/scsi/lpfc/lpfc_els.c:10830); qla2xxx clamps
total_bytes to sizeof(item->iocb.iocb) == 64 in
qla27xx_copy_fpin_pkt (drivers/scsi/qla2xxx/qla_isr.c
:1170-1171), so qla2xxx delivers at most 64 bytes of FPIN
payload, but the walker bug fires regardless because the inner
walker never consults desc_len before reading pname_list[i].
qedf, bnx2fc, sw-fcoe and bfa do not forward FPIN ELS to
fc_host_fpin_rcv() in mainline.

The in-flight v10 "fc_els: use 'union fc_tlv_desc'" series from
Hannes Reinecke and John Meneghini (linux-scsi mid
20250926000200.837025-2-jmeneghi@redhat.com) touches the same
file but only changes the descriptor pointer type; the u8 i
counter is preserved verbatim in v10.  Can rebase on top of
that series if it lands first, or land this fix standalone
against current mainline.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

