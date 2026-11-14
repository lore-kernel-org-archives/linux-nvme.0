Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82705606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zOZwcmhE;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ggNcsLaZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=; b=zOZwcmhEkn2UHl6M6Q+AG95fPf
	tjxbM7SODAy8MPQKiDPIvw26qwJ4xgOBND/VWNmaRB2Azrw6dZEfHtNYhDF0UEMVMzfLMMHNaThnb
	l+zBQUgKPloju2JmEOLQTKR5q4Dc2Hym9qdQig6t/Lrd8MC02N88vSjtpjiq3X3nkbWX6rl+z5pkd
	OifyQ3rZwX5ZNUQ5YCihugNKOuaNeRytkFBB8SZlw+kYMCFVq/uPxyNPRmZfsEPxKxsy3yiQJlmFU
	wNXJW5bt7LnB71zYshbdm662eZgYxu5jHZI9JMN2aDZL13sO27NMJnS6jF/Rzmy02fo59hatY+Y+N
	pQzSJRJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw0q-00000002R2S-3nr9;
	Mon, 16 Nov 2026 12:40:44 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSK0g-0000000GhyO-0yMW
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 20:06:03 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2076437a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=ggNcsLaZVnIVVFfhKgipS4O5oMTd0y32qS7G7Xx6epyF6A3PBP9hmhzqIHktMgI190
         E8qOelRsgPh9aJFQmQtSHzJSn1WloCKpxP+CbPkxNz6+wAUHB2xYWa9Ijm/TYIFYovZ2
         DkYrJsGhPtWIaS9ucBy742/30MFrwXdnwOXYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=CPOlUaOt5KsCiluHWQWLW+Dw+uytLjoTyYAvCqmsNUv2tlOeKN3OqiO2o9vzH1k3bP
         eoD7JJs7z6jyXHPEYn3WdA2Y89ZeTBE3O2tMpcew/3JMDtwEJLVyNTInZ+hJuUU1YvIp
         3JYKoqLS/duKPvIRADMRevFTQrqGJrMZtPlLLHENEszfedRxBvMSLe3HtbWU+m0em29m
         PD7Gnb326BszumEOlxmxav2KKFFbqNsDyyN5gVRbhjpiiv0sieu7hneyMFwWER4/RVBC
         vaonQ7iKLy5ZRK0vPGk6j9w/C21J1JKQlwnPpXuuuA0jxpQq2f/cOw/aa7NxC+qsbJd2
         FkSg==
X-Forwarded-Encrypted: i=1; AL+hErEOgJHv1vqjc23ix8DB7C2gXAjlhAXhaqSngcRE/9e1z8zqE+7HJvzmodnsiABKJeAA/LGXuiIKsTWp@lists.infradead.org
X-Gm-Message-State: APuU4Z8vjweVPY8HrTinYQ+IwSDmeracWUVkVmUX6L/FIEr4sM0lw3vJ
	2g4N3Yt+P7Fnaxf05WhbyHC6AuJKvvID5ieLNArTdiCBlZhL46FrGH0wI9yvhorsrIA=
X-Gm-Gg: AYBFou23qdv2q26BXFGxBjxCGLGnsVdYROa9CSSVwVdzkIj2LBYFlMB5sHvYUItnfjU
	MxpLTU2ePvMmIMrVeardYGa4HNAqoixJx6+wd4EfQppq4dhcw0wqdK6WHAz1zWImUESWokYSE8v
	13oF77Ecm3LMgpzO4lRyO5n9w2G/0gmT6czuRBJsY34aAPFLgai1/ocGjg4mqs7jfM+YVM7D75G
	zRmeyqiwUBmvuwGDC9mGkB9t/saE1BO3wVHZMOFtdT8nx85rSd7WUe6/NGCoVCFGg227F5MHYXV
	yJQZVbCHFs1NdUWW+4fd/PME+FuW5IbXm67+SjlHy9kRCYh5LiiHQKieByf3fWoIDLndcYHQvem
	SsnAdt6H+bxvUoFy68k4Ol3GH/9R7zqeUEVlay2r6DvTiUHeiZFOVLtqukN9kYlj+yLGEhws0St
	lLeL67LjqcXCQZayQyTNKFALNKhiR11FO7yuEVgU0hrk90cT6GUTYcZ1+q2ejAspVUiSznS1Gzi
	nU3ucu6VfJttoer5DtO052iVnnlvwU4/Zz6ikoiAViLfcc0X89qnQs/LCZRFm1jNiFAmWiACQcZ
	T3OJ6bePx9yUf+cxwvLIT1VYY022URdE2qcpeqmQ9GCBx+emFX0Tm2B6YcuEnFbONGXDEziJNFv
	aDMA61byQoQFzpAdZp/9nFWxRFP15f0a4r0OZ5QdYIOOPRmn+8TWY054pBPKlkaLtUk9C7RFNoH
	r0oa1HO53LGT1nXlAn0gOtJw8Pc7vdkrjESOGvA+x5vGyY5Maf5J2Guq3g
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_120602_280868_3F0BBD01 
X-CRM114-Status: GOOD (  12.49  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:40:40 -0800
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris

