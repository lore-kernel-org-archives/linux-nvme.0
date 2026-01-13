Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434F1D2D10F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=; b=HjoIfaLCAmmYQNWC+A0ris7EdA
	UxC/Jw5T3w5r2Sl4c/S9lVZ2cS2eHrA6JZ9bZ/yVtvstvPyQMVdFDVsnEhsgYS8/SpCypQQQIxR24
	7m58S66Hf3W7XDfMiQd6Pj686DLo0FKoPSBev06ghlfNbxezZUsIUI2/myNFDqXOf6awHBKGxI9nA
	8OlAGjYXo/UOII8scoJSpoGZa5GVfEcFUV0pCVlETDeVN2EPj2n3Zbb1oy9P1Xfp3TWBhkiSlWOfO
	Mre9O+sFGA82EPAJTWRDBfg8kDsep+mD4GC607xkwIHyJ1uOP78voCQbyOb/2RgLfsFJjlqE/LiNk
	DbXaQN5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffLN-00000007Fbw-3A0s;
	Tue, 13 Jan 2026 14:26:01 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffLL-00000007FbI-31XW
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 14:26:00 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-3ec6c10a295so3354950fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jan 2026 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768314358; x=1768919158; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=SBUU1hN57qPF0u9gy9JMfGtYinYQ/lViAbl8G6Vxz61OMNyXUbMpgKfgMI/ns/gURp
         BIU2bjs17wsoFDW9QP32RF3XcmJvcF/5TyYwADF1Xe3FSjgtnb386JfxQTcLbwiULz8Z
         nUa3wyIYEzOdsIGQVopajSvE/Wrq8tUIInFa1SS7QXPpdihCdtyARhQN0CJfypyKEagD
         wuBrsf+AaAht4veZFqQSuQwNL1QVrdprdXFBZnu5GnlCLLhTV6fe4kDTwXeTGSTi2+Mk
         aQt/sj5DHHwmV+pu0Hpd3qSRGJ745YOabhrZ5LD/63qWiLV7YT181p9YZM47CJ11doh6
         KAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314358; x=1768919158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=dMWJd3nTSMzHla6KKTibJ8dxZeMzZImDflVMb7C2GjvUrBDjOin1SoZpbifJVcwk+B
         lsYp8/F7N3YLhZf1qwvhySSy4u4Ao1gwnZQGXAdkFnXlR4qvNXJD1NLHFPFSbl8rzUet
         4rzinOyvjXg26BpYEHVwvoTde7JExz/pGYrpaCDDgQUkd/n1B/0zRlw7aw371azh3tU5
         C7r0TzscfKKlT8ZCpWeqNAkLzTgM751xDYxTe6A2iiXa5YvZ4MF3uQbm6IpMFygjPJAj
         DRFZqgFMK+od8ioYaC2HqVDhN2SivOYf9WVXLCZxj98De68WfHi+ipfh2UxGTz0A+v8C
         duUA==
X-Forwarded-Encrypted: i=1; AJvYcCW0xfyBK17+MjDR6xY5o9ZAfinVMn/Esh3QxUoTgkn7vgTDE6RXihhJ9vWGO2LGizkuc2n8jbF+ngx9@lists.infradead.org
X-Gm-Message-State: AOJu0YwD6aaGNeVsXLr/bmZ/ykrqnI0k86EDdRDPyuMIKjEoC26dhGQZ
	AhtczY9HVACTODIG+n4RCKfQ1N+E83T1gksSE1/AeB+iqMAMB26ETgwgnbq68R8lG67+A6Go4Lw
	tLBQGaPsGVJ1AcvHJUXHFWBJf44vKVOU=
X-Gm-Gg: AY/fxX6SzipzugyAKInIlEGIPVIZjHQmiGfu6h/Dcndacbn9k+gE9aH+CRBG2ibTf0i
	LO+8XzWJqyTxr0p99k5LtDx1XtggvmQxdrz2QhjmD7ZF+bQ4qsBAA1ODKcV5U4NrvWdwByRCoSD
	gtGtMRoEAkMN5ldenpvr/rnn5l72xfQAd+6SW2P377iJiP4dCtpSxTTGcSgsnw3iTMPdMu/Q/KT
	cPVtjzc6l936q8NQO7c2cWd8lcxVYiE6PiRFne8fh3otEXu4rU81Hucc7dey0Nw4xhDrfOun6K2
	72DU/wIhqJFvsywekUxMe+BCz99GEHefDehg5JadPkkeB5GX/PHwXZxNEas=
X-Google-Smtp-Source: AGHT+IGXEVyxh1r5DpDmVWhueY0N+0Jp3e8jPwWMKfuSFBTgriyw1P/K6APHWhYtB6ZeNT6dhK47KGYvJrt1woGnjOU=
X-Received: by 2002:a05:6870:32d5:b0:3fa:966:a847 with SMTP id
 586e51a60fabf-3ffc0bf65acmr10505770fac.47.1768314357848; Tue, 13 Jan 2026
 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 13 Jan 2026 17:25:46 +0300
X-Gm-Features: AZwV_QgGmVCLvOrE1mbQJXUeZhWwA5eYHysOC7ryKk27-LWtIhw5TW2eG5CG-5k
Message-ID: <CAPqjcqrx=9HOS7+ywoxqsiTQWTtb5G5wE3ydNLzfN4Lq9W-3AA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_062559_758045_AEAADAFE 
X-CRM114-Status: UNSURE (   4.53  )
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

Hi again, so what do you think? Can the restriction be removed for raw devices?

Maybe we could consult with someone else about my question?

