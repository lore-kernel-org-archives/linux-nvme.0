Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7593CD5BB4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pbYIBGOEmwzLz4cPeDZTCHq1J54eRqPgjWFbvt/fJSk=; b=kj+8OECSaYfa7ULu0+2y2ASzrQ
	J2PfnuM0tkrgkz/W3QF9/vu802LaMxyE+ui1Cv3RvUzegWewQ/9/SN7Vi9+Yf65XzRyom84qr6DXq
	kCVtyGhx1lUZMKVDFVcZY62dTl2PdBOb/5/UU76NXu8igMLkOBTZb8EBPrX5edJGa0yav7EHUrIe8
	fLKvfO0r2BEp3rCcyNAszQzdpo1caGPEFjmyxG6TZp3wHDzdV/UJVXC+FGUJMUIv99PwumplQig0J
	5RRfOHy3kLjb79rPb1TkE2VYRWxxqgq+oDk4RyuS+cLtqO5cZytFgs5AFpB4L38gTdAfq3kSu3tcJ
	9JIjYsDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmag-00000001JWe-3enI;
	Tue, 26 May 2026 07:52:42 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmae-00000001JVq-36i8
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 07:52:41 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so51692055e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779781959; x=1780386759; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbYIBGOEmwzLz4cPeDZTCHq1J54eRqPgjWFbvt/fJSk=;
        b=bLMAD9SR57eLdyic5pqIfHqm+HV5Pi50JrLg1y6/ljjVmZpktKSDcHE0nkf8cI505y
         jILUA9pkmV5Y4O3qcUILM8w/riNTQDOzyoCrC9pd5dvCeUv0zblylXSSgUTxtCPtpP9e
         RvOYCFiqS1lTGo/l+NpvP/7PZBZ6Bv13LMIPNPdMTeOjMaJdi0+ZduCsbJWR1tzthPPL
         1T9tH+hcoDfFFloFeV4hj4SxTRZbg4nmUbfUqpyNZ4RehBrG9eyQqcCdqlfBNaLf8qF6
         SoSV0g3xZwYqzdEcsb6CjfzopEL7G/eZvsp6okZALgJNFz+LDukjyKhKaKfqGOxceLn/
         w+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781959; x=1780386759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbYIBGOEmwzLz4cPeDZTCHq1J54eRqPgjWFbvt/fJSk=;
        b=hvJRAjFbrR0A4Ujleahp0+nHc8+778iEVkknLH5PlHS05JYRZwKAuJaS+7hnkWJKiS
         aaC63e9urHTjapXm24OPi4Y/O8w/5bLKR2iKH66Np1ERp4WpBDjS2VqweHP7ZBSk7Qmq
         a6t8g2DT+SILDsQYL88ClfaPiDDJc4PWpOlvNM3Fwjrvk7HrFfuIUkDwchd0tEVg38pO
         usuTNVDxnqvseS+8L4dFIhrMdPzL4SddvPOljtUvq2D/Umnv/KFTbmF7WITVhdB679Yj
         Q/8Co5BbNbkPUy37F9y+FZN1KQg7I02hlkrEs/Q6ObdwnOko2Haqm3YWhULv3GhLasuR
         PjEg==
X-Gm-Message-State: AOJu0YwCCb/LZiQNUM0TPYRILNEKM2HveNbcOzSE70/ddTLfhLfu998h
	Kx6qYf/tMNwYuIRRuBVh6IyAAXnQoJaq87MMCNM0eIbeMnnS1783Frmsoe+ipmpGFdap6Qfr
X-Gm-Gg: Acq92OElT9O1ohSETDIU/A7gsxUfG9E+rrpB3AY1DNV/19y+NeBsm8A+3qHM0a5n6LC
	oZRF8ORlNEkdD7IOVRqv0G6LXGGC1rKC/u8GVCQ4nseRoWeJE7UXGa435KEZcLlit5MhPBzdjwO
	JlzqnuG974qqv2/+gtwUbuHwpE9+lvks/VGwUOjqn5V4UQPx/Up8Gbf0DtURyj9WN/NDfRixykj
	s5teWe01AhxeXJmYtZr5Z3GgxvOtFsJD49lptqHaJ6muSTR0mik2O8lgiNDzjFPOHwk17BJ8ciV
	ZVnosYCT1dkzjpDGYrTHj/kSH/P/XPEaHpUxMbIr6Hta3K8KE9ENcWJSLWKFiSxMSkFhOfseaM9
	87Af4Dt+D7dunbC+A4uomTYUcQOyvCvE1RNPf9ylynoB/opWWbgZ5u/c7HkYsWlLEwTd2ImHH1X
	/fao5eWXLVPOVW34rq3vJSfWsRUc4F
X-Received: by 2002:a05:600c:a213:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-490424ada3bmr187126135e9.12.1779781958408;
        Tue, 26 May 2026 00:52:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3803:1cdc::2e0:83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm540682825e9.1.2026.05.26.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:52:38 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] nvme: fix FDP configuration log parsing (NUMFDPC / fdpcidx)
Date: Tue, 26 May 2026 15:52:35 +0800
Message-ID: <177978195555.4106423.1566684328319724660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_005240_802699_391B2A50 
X-CRM114-Status: UNSURE (   9.08  )
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

Hi,

NUMFDPC in the FDP Configurations log (NVMe Base Specification, Figure 279)
is a 0-based count of configuration descriptors. Valid fdpcidx values are 0
through the NUMFDPC field value inclusive.

Since commit 30b5f20bb2dd (nvme: register fdp parameters with the block layer),
the host driver used:

  n = NUMFDPC + 1;
  if (fdp_idx > n)

which incorrectly accepts fdpcidx == NUMFDPC+1. When forcing fdpcidx=1 on a
namespace that reports a single FDP configuration (NUMFDPC field 0), the
unfixed driver proceeds into the descriptor walk and reports:

  FDP invalid config descriptor list

This patch fixes the bounds check and also validates descriptor sizes while
walking the descriptor list so dsze == 0 or a descriptor past the log end
cannot cause unbounded iteration or reads past the buffer.

## Test plan
- Build: make M=drivers/nvme -j12

- Repro/validation (lab):
  Tested on linux-next 7.1.0-rc4-next-20260521 with QEMU 8.2 nvme-subsys,fdp=on.
  With a single FDP configuration (NUMFDPC field 0), forcing fdpcidx=1 triggers
  FDP invalid config descriptor list on the unfixed driver, while the fix
  rejects it early with FDP index:1 out of range:0 and skips stream
  registration.

Thanks,
liuxixin


