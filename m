Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898C606A333
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KIHwah6H;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=qpsHuCYY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pALWi25PaiwvAzQ+rk8fhccHyEREP1igMqQCrUiFzbI=; b=KIHwah6Hf1nDaL15BAPqUKwymg
	8Lsi/uKu0pKCgVPC+ycyCH7BszaaiHO6EquN/AKbcD4c0fv6szoGcAmDbA/qny84Z93+XrGtuCXa+
	9WsqFsDEdN997HpDZ/X2l8ZIVfk0W3wWt79GyoYOe55CqHdnJtqj8bGd5tQ5Yusdq2AZY8Rr6PiF3
	cQYzs2zF/Zz1T7Pegp5dxr88/6Rn/j6iZkIR8F/17RfKzQJKFpmppuUyK5/jAKijPqeybQpMA5aR/
	1f36KchaJrNRBzAWUFL6T8Msn+LWy802x62TbUmVFIzWrj5RCueF91sSAeXFBsZ06vVl6GK96mcQZ
	AQS+UEiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR9WM-00000006zW6-3oH1;
	Wed, 11 Nov 2026 14:41:54 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR9WJ-00000006zVa-2enJ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 14:41:54 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmS3625Gz8XrrX;
	Wed, 11 Nov 2026 22:41:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408100;
	bh=lJs51VmRkrJ/aPe+W6Tb69qPGEvDYZ660PLNVtEO16k=;
	h=Date:From:To:Cc:Subject;
	b=qpsHuCYYdkNZfvk63f8VQtzXiptxpbfgcAl8sjy97EzId+x1zlIIBok/tNbgnj9ks
	 /0KWNDL8Rl1Yp/zg8IfUyLKHD+AvB6WH+ALEUZxeIF74EcRSdCzjHNZZ0M6ZGoeE21
	 GT7AO4ZX957InBnpzsbBtFOUk/5za5OwXgj913f7rFfQHETTa97gtZHrzuGOTyzF0o
	 6BP0OARlwqK9ZQ6ll1zdX/SBI/6SCRkAhv4Fgzd19Xp7l3aEqUNp4DdcqQozz1Q7F/
	 2YKxuIaC/qlQKsnb4wMfKmYQUU6PRWnY9jm7Xl2dsXPQCOZt48FyqZ+nqV17+XBYmf
	 bsRfvzdUvFfOQ==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ABEfVTW094209;
	Wed, 11 Nov 2026 22:41:31 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:41:34 +0800 (CST)
X-Zmail-TransId: 2afc6af47e9ea78-5c968
X-Mailer: Zmail v1.0
Message-ID: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
Date: Wed, 11 Nov 2026 22:41:34 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBmaWxlIGJhY2tlbmQgc2hvcnQgSS9PIGFuZCBMQkEgcmFuZ2UgY2hlY2tz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ABEfVTW094209
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:41:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EA3.001/4jPmS3625Gz8XrrX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_064151_861301_35EF4EAF 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file backend computes byte offsets from the LBA and block size with
unchecked 64-bit arithmetic and does not handle short reads or writes.
A host can therefore make the backend report success for a transfer that
only covered part of the range, and a large LBA or length can wrap the
range check and reach vfs_fallocate() with an out-of-range offset.

Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
instead of advancing the position and eventually reporting success, and
converts a zero-byte completion on the common path to -EIO.  Patch 2
adds a shared overflow-safe range check and uses it for read, write,
discard and write zeroes.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Testing: both were tested on 7.3.0-next-20261030 with the loop transport
and a file-backed namespace under QEMU/TCG.  Patch 1 used failslab to
reach the chunked path and a shortened backing file to force an
incomplete chunk; the unpatched target returned 0 with the tail of the
host buffer unchanged and only part of the write reaching the file, and
all four cases return 0x6006 after the patch.  Patch 2 wrote SLBA 2^52+1
with a 4096-byte block size, which wraps to offset 0x1000; the unpatched
target accepted the command, and it now fails with 0x6081 (Capacity
Exceeded).  Both patches also apply to next-20261105 and pass
checkpatch.pl --strict with no errors.

Shao Mingyin (2):
  nvmet: handle short reads and writes in the file backend
  nvmet: use overflow-safe range checks in the file backend

 drivers/nvme/target/io-cmd-file.c | 48 ++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

