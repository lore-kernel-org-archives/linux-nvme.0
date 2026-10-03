Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E390ACA5FC1
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=; b=rS8TWojXfCpTLw8EFunEK4h+gs
	/8vkn5PkgwnlVAJMrdL4g0VohhIyMPjfuh/yL3LkeflBhWgSlaFP/t9j7og/GoNa65j6fVWITP15A
	/YtWdVpjoG9E+ss+Iz0jzVRg7v8iepsfWHTdTmgzD8LetHykiuqO3ZQImT5aUqw+MklfazQRTxcxX
	eM6WAbLfoKO8PdJaKbbUoYtlJ5LbCwuZpjCl+rS+nzd3GAcSqArxoVW6sM30UOU7g9Ejr4alPZtB+
	278FCz7AaSLR8o7+PGzDJ1QTx9kixSrnUdXi3Z+OT7EwFMLstRNn9Fi4LE1fFAQk/Sztt7vB1Pd3k
	r4c18faw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzDl-0000000DVZE-3vyi;
	Sat, 03 Oct 2026 12:52:09 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzDi-0000000DVYr-46Rq
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 12:52:08 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3510f00d974so679566eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 03 Oct 2026 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791031926; x=1791636726; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=;
        b=dmFT43XETjWq/eQFLdN+gfXNm03uqdcfNqBQQs3uXKHrQFmytb0tBfnpoKZ0GWcRmM
         ZbpBsqTDZczESYJmUthZUKKsxLy3ZOTN+vtlN9SfYIiixEIJL5yw7vasFwE7jNSJ8kDA
         +QAaq7PVxftro4IavEO8BJ6I25EjZz3ZbpUmHdDYR1sGKp+t8+LIIrw04cN0PcQo6XVN
         1q+UP0H3159cHeiPM4MmPk9snbJehkEYkocd4mrBG7D2nBUY4icMTgbHJqPDWR++sHaP
         HCP0QIbV+S3WzpiySzrWVgOhQi5zlLMKdII44dz1cQ8b9sQ9DennXrEt88Mjho5cV8Pn
         0qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031926; x=1791636726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=;
        b=OK8KfWm2Xpf5TLwjPVk8Ekst45XhhEkNeAn2Ej4qZb38PUivXH29H4ai2IA/VIcviX
         qyYd/zQSbl6VjsvmM9Is2L5bVnJBcHqmx6yPgWvm0dL4e+uw1J9gJd+rXIPKJyPwZLtW
         Ok7L1AbKkRYvSjHNwnQBkQfhzaiRgi7RkwU3Y37D+D1xUdXn6SWJLFIgJV5YuRemP8BC
         A2ZVi+d66sJnYbTBuQg4Kn/6/+adyESs+FjukJ76x8jpJRWr/Q3+rQeGurKp2uLc8vmq
         anpJ60KmuS3rQvj2VZY/wfIfLcTKz0WfgEaGFQoQObtqdmXZ2FhoHM6IETORg3l//31Q
         1Ryw==
X-Gm-Message-State: AFuF++mu0/zUfAjswj5im97cy7y7maNtZdO6mf0BGHtORSyQLO3DdeRM
	6DsqZwRTFjHsl3xkQ8gOjKUIokf74d9WxlgYPPtWoA7/wv/BPtid61z/waSc01Yw
X-Gm-Gg: AYBFou2I12wiFY/fITFVGpDgUCsjvA2JEuey9tpC0KTkSffhNnf8zRShUlbcb5usM/d
	g0QYct9gywRDI5tvfQ6dppyFqfTBJMJuf6uXAgZzy3hVIXfd5u0SgJ4V2FUV/zSRV1pmSLAar24
	0Gkn9Epm93vySB2vu4G4Du3QrHenYEeUH0FwDm1X6DNrsLGka/6oISpKhemVRlgje8nIaXXIA4h
	ecDgLSYn1CbdAmkRXFHQkzKZ+HCSJvvmWDW6kxd5D/8BlJJrOz1KhYVQOzjWv6dyrf5GCn1JTKI
	dfct3GEpxtoBAWUQuWyUUNXIjPGeNH53aHP3dRxvMViBbjWjlKXkucJnY6deri1BpDuLgEapHJq
	NPe+5JidJDdXobsVNIYT3oXFHRfjs4QmTuLIVNjCjwu6EPl2YTVwqoO/J2bch2TwWsPreyZ3q3M
	efU/IZo6PhrLDl0H0G7QwLZa7H6V8z2eGHNvB1N2fpvB6HPsNBLmQ29tZxR8+dt//mjg9eFFDlZ
	5ZbSkHLtnV5GrjxLzSl
X-Received: by 2002:a05:7022:b057:20b0:14d:38f1:b51a with SMTP id a92af1059eb24-151c32dbd2cmr3274138c88.19.1791031925506;
        Sat, 03 Oct 2026 05:52:05 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm6211515c88.5.2026.10.03.05.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 05:52:05 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Subject: [PATCH] nvme: auth: validate DHCHAP secret before stopping authentication
Date: Sat,  3 Oct 2026 12:51:15 +0000
Message-ID: <20261003125115.2523-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0602191a-81ce-4f8a-90d0-b47ba2bc36ac@suse.de>
References: <0602191a-81ce-4f8a-90d0-b47ba2bc36ac@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_055207_023208_814B8A27 
X-CRM114-Status: GOOD (  13.23  )
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

Hi Hannes,

Yes, I agree that stopping the currently running authentication when the admin requests a new one is intentional.

The issue I was pointing out is slightly different: if the new key is invalid, we never actually get to the point where the new authentication can be started again. "nvme_auth_stop()" has already stopped the existing authentication, and the parser returns an error before the restart path is reached.

So the question is whether writing an invalid replacement key should leave the previous authentication stopped, or whether the key should first be parsed/validated and only then replace the existing authentication state.

If the intended semantics are that an invalid key write should not disturb an already running authentication, then moving the validation before "nvme_auth_stop()" would make the operation effectively transactional:

validate new key
    -> error: leave existing authentication unchanged
    -> success: stop old authentication and start with new key

If, however, the intended semantics are that any attempted replacement stops the existing authentication even when the replacement is invalid, then I agree that the current behaviour is intentional and the patch doesn't fix a bug.

My concern was specifically the former behaviour, rather than "nvme_auth_stop()" itself.

Cheers,
Sreeraj

