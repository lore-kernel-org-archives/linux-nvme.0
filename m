Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230D5CD4F3E
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2xccyQL0wjRPHWCif7a/agPdP0N/MqlaSpRLb12d9w=; b=mJWlm36tTruuH9TDTEc4Yoi2ct
	EbXMQzNlyUndatFz1hRA+9lnStEaXN716pNGV8t1aJnHxnQR6yW3R6dlBg4F6XkJ5xoAh45qc9E22
	o0HGZV1HHISRdooxdELe4z336ytary3HngK6pdriPGfkArGYz3a1gHinn4X60weYod7Ux5SPX0KDT
	EaQ7+uhx2M9gQXb07bks1GkAom6UhCYzySgWPZ9S4g2jYcAsrysPPjDydI5m8khBrraniHdtaUFGL
	oDQ84PL+ZLVILSoXDXr9doEVO9dgvGMPc+ap5cz7xHokmBYAKqJ4FoDcmUNPpPGYpfcoonYWIcY/p
	dDUV+Y3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKa7z-0000000EYDC-0c7a;
	Sun, 16 Nov 2025 10:37:03 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKa7v-0000000EYCo-3Rm2
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 10:37:01 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so221776b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 16 Nov 2025 02:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763289419; x=1763894219; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2xccyQL0wjRPHWCif7a/agPdP0N/MqlaSpRLb12d9w=;
        b=Kw43ZYbS3jL05PRzZlTuezepFSVOfhFOn4ddweP8QKYgwgAoDdtBccy4cl5xTxVgY9
         fNsAIXhj+Kbi/AD/J4l9aGdZaWbRfmwqFiDWR6xIsBDZVE/USrT15FtaOjjzRRMYwmfZ
         bPSVvS15j2lj1yDqijInS8cVuYRMr9KKJIsILQzW/T9sXFEDiRU77Eb3Z3AlHWqih1vb
         jkZQxxVwoUCD8g8RdKTJxJEs7aNwAllga3+nMrc1O9BZHUh2Pb+V2mSP+YrJvOmgNwA5
         vbYh0w9grMKqnMkHDhOoQxqIKsf0XDSKtfnD3Xpf/pOYiLIg2UY/r3cY8vdE5DniOUO3
         nlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763289419; x=1763894219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2xccyQL0wjRPHWCif7a/agPdP0N/MqlaSpRLb12d9w=;
        b=KAhRkTR9aib6W32X9/yeGoa9X5GjSkqywo4SKsiEYaMDpAW3oFJ1OGPsvrCoJPsP63
         65XPL/IZ6W6/zE1jxP/sJS+3knnDJllFIzkVudlrsdethiZNJj0XULtOb4b218Q68Z3X
         /Am+UAfppkMprBkjOhq6D7UQ9L3NCfUCnL2gSkf5xHnpc2hKrNYYHQ3BaZwtmAbAgLR+
         WW3JyfAz+evH9yIQMvbO92Y+KLEwTIJcFw0bjvcZeQOf6lECEzbODxDtszfz10D+2hh7
         gyEx3CUOl2i3+/HtjbwmcCV5d9RBi1XytBNL0huk7T4Vama08lbSKvwLSbV4oIzs1LNg
         Up6w==
X-Forwarded-Encrypted: i=1; AJvYcCXDkN6IBhby5GCQ8iX/1Q1PwDowMrilcQTnbgYfGvyz/mPkQ/1Jgt+RpqoIvL72OZkIIQcMRKFUXQWY@lists.infradead.org
X-Gm-Message-State: AOJu0YxeQ0S0vkeq38jkYouAVBtUs+qNdOPggXnmKnNJsQ4GGFmQNZGs
	0KawxAvi/0GjiAvsCa8+puO47vY+DBHxOID1TocE7bg7emteV86I9P2Z2Gkk8E6pH98=
X-Gm-Gg: ASbGncvu3oKChHI4Et1ZF2vluYvkgmauZI1F9ZXxfE9zLljMtNZ/BppQrB+kOH8skPk
	yaYFxjpWJxfLmRPSCOGqb4cdxO6VSqHaIwCoUUofssxOGl3zkALP4L8hHr6wJ9npRZCsmHIUJjV
	CfcTuBg0gfhU8vpQ17A+bYvgf0fvDOIQU0I97lWJ/KajZPta8FHK5QiUMis2fnnjPKANNo5Q6BH
	0dJk+PTl67EvYxafCNCHWqNdV5VjxsKTfB2E+4Y5q+uHJZLAziOyHQ1tzMBock+e0qdH6Uo0IKO
	Ob7m3M0ajP/XeHiGjcibzH2Il2lxdhD9ntZCr2UHwyuykeurhTH6Sn8KGjhKsXYvWEUPYRG7LG7
	EifDe18t6WkaR0aQI+S++S6xHKo26IcWE2+Nvr+fejZLIb10CkvmbLBr6JTVIDnotUMopJJAtBE
	7y66zGYIL4tXj0MbVh+x6ASP3sz1Jped3R
X-Google-Smtp-Source: AGHT+IEnf43Ltm/bA4lzbDQv+6sO2UhNpxxLrJK2n5FBPc4EJRJYJDkn08A4bHCQNvaKnyZ/h6JUVw==
X-Received: by 2002:a05:6a20:7d9d:b0:35c:e441:e6d2 with SMTP id adf61e73a8af0-35ce441e898mr7014829637.7.1763289418602;
        Sun, 16 Nov 2025 02:36:58 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:22b3:6dbf:5b14:3737])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36fa02c42sm9507887a12.16.2025.11.16.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 02:36:58 -0800 (PST)
Date: Sun, 16 Nov 2025 18:36:50 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"hch@lst.de" <hch@lst.de>,
	"home7438072@gmail.com" <home7438072@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"visitorckw@gmail.com" <visitorckw@gmail.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] ceph: replace local base64 helpers with lib/base64
Message-ID: <aRmpQmMtfZQ8f95s@wu-Pro-E500-G6-WS720T>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
 <20251114060240.89965-1-409411716@gms.tku.edu.tw>
 <afb5eb0324087792e1217577af6a2b90be21b327.camel@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb5eb0324087792e1217577af6a2b90be21b327.camel@ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_023659_894222_E552DC71 
X-CRM114-Status: GOOD (  33.24  )
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

On Fri, Nov 14, 2025 at 06:07:26PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2025-11-14 at 14:02 +0800, Guan-Chun Wu wrote:
> > Remove the ceph_base64_encode() and ceph_base64_decode() functions and
> > replace their usage with the generic base64_encode() and base64_decode()
> > helpers from lib/base64.
> > 
> > This eliminates the custom implementation in Ceph, reduces code
> > duplication, and relies on the shared Base64 code in lib.
> > The helpers preserve RFC 3501-compliant Base64 encoding without padding,
> > so there are no functional changes.
> > 
> > This change also improves performance: encoding is about 2.7x faster and
> > decoding achieves 43-52x speedups compared to the previous local
> > implementation.
> > 
> > Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  fs/ceph/crypto.c | 60 ++++--------------------------------------------
> >  fs/ceph/crypto.h |  6 +----
> >  fs/ceph/dir.c    |  5 ++--
> >  fs/ceph/inode.c  |  2 +-
> >  4 files changed, 9 insertions(+), 64 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 7026e794813c..b6016dcffbb6 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -15,59 +15,6 @@
> >  #include "mds_client.h"
> >  #include "crypto.h"
> >  
> > -/*
> > - * The base64url encoding used by fscrypt includes the '_' character, which may
> > - * cause problems in snapshot names (which can not start with '_').  Thus, we
> > - * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
> > - * which replaces '-' and '_' by '+' and ','.
> > - */
> > -static const char base64_table[65] =
> > -	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> > -
> > -int ceph_base64_encode(const u8 *src, int srclen, char *dst)
> > -{
> > -	u32 ac = 0;
> > -	int bits = 0;
> > -	int i;
> > -	char *cp = dst;
> > -
> > -	for (i = 0; i < srclen; i++) {
> > -		ac = (ac << 8) | src[i];
> > -		bits += 8;
> > -		do {
> > -			bits -= 6;
> > -			*cp++ = base64_table[(ac >> bits) & 0x3f];
> > -		} while (bits >= 6);
> > -	}
> > -	if (bits)
> > -		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> > -	return cp - dst;
> > -}
> > -
> > -int ceph_base64_decode(const char *src, int srclen, u8 *dst)
> > -{
> > -	u32 ac = 0;
> > -	int bits = 0;
> > -	int i;
> > -	u8 *bp = dst;
> > -
> > -	for (i = 0; i < srclen; i++) {
> > -		const char *p = strchr(base64_table, src[i]);
> > -
> > -		if (p == NULL || src[i] == 0)
> > -			return -1;
> > -		ac = (ac << 6) | (p - base64_table);
> > -		bits += 6;
> > -		if (bits >= 8) {
> > -			bits -= 8;
> > -			*bp++ = (u8)(ac >> bits);
> > -		}
> > -	}
> > -	if (ac & ((1 << bits) - 1))
> > -		return -1;
> > -	return bp - dst;
> > -}
> > -
> >  static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> >  {
> >  	struct ceph_inode_info *ci = ceph_inode(inode);
> > @@ -318,7 +265,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
> >  	}
> >  
> >  	/* base64 encode the encrypted name */
> > -	elen = ceph_base64_encode(cryptbuf, len, p);
> > +	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
> >  	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
> >  
> >  	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
> > @@ -412,7 +359,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> >  			tname = &_tname;
> >  		}
> >  
> > -		declen = ceph_base64_decode(name, name_len, tname->name);
> > +		declen = base64_decode(name, name_len,
> > +				       tname->name, false, BASE64_IMAP);
> >  		if (declen <= 0) {
> >  			ret = -EIO;
> >  			goto out;
> > @@ -426,7 +374,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> >  
> >  	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> >  	if (!ret && (dir != fname->dir)) {
> > -		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
> > +		char tmp_buf[BASE64_CHARS(NAME_MAX)];
> >  
> >  		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> >  				    oname->len, oname->name, dir->i_ino);
> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > index 23612b2e9837..b748e2060bc9 100644
> > --- a/fs/ceph/crypto.h
> > +++ b/fs/ceph/crypto.h
> > @@ -8,6 +8,7 @@
> >  
> >  #include <crypto/sha2.h>
> >  #include <linux/fscrypt.h>
> > +#include <linux/base64.h>
> >  
> >  #define CEPH_FSCRYPT_BLOCK_SHIFT   12
> >  #define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
> > @@ -89,11 +90,6 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
> >   */
> >  #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
> >  
> > -#define CEPH_BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3)
> > -
> > -int ceph_base64_encode(const u8 *src, int srclen, char *dst);
> > -int ceph_base64_decode(const char *src, int srclen, u8 *dst);
> > -
> >  void ceph_fscrypt_set_ops(struct super_block *sb);
> >  
> >  void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index d18c0eaef9b7..0fa7c7777242 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -998,13 +998,14 @@ static int prep_encrypted_symlink_target(struct ceph_mds_request *req,
> >  	if (err)
> >  		goto out;
> >  
> > -	req->r_path2 = kmalloc(CEPH_BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
> > +	req->r_path2 = kmalloc(BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
> >  	if (!req->r_path2) {
> >  		err = -ENOMEM;
> >  		goto out;
> >  	}
> >  
> > -	len = ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
> > +	len = base64_encode(osd_link.name, osd_link.len,
> > +			    req->r_path2, false, BASE64_IMAP);
> >  	req->r_path2[len] = '\0';
> >  out:
> >  	fscrypt_fname_free_buffer(&osd_link);
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index a6e260d9e420..b691343cb7f1 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -958,7 +958,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
> >  	if (!sym)
> >  		return -ENOMEM;
> >  
> > -	declen = ceph_base64_decode(encsym, enclen, sym);
> > +	declen = base64_decode(encsym, enclen, sym, false, BASE64_IMAP);
> >  	if (declen < 0) {
> >  		pr_err_client(cl,
> >  			"can't decode symlink (%d). Content: %.*s\n",
> 
> Looks good!
> 
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> Have you run xfstests for this patchset?

Hi Slava,

Thanks for the review.

I haven't run xfstests on this patchset yet.

Best regards,
Guan-Chun

> 
> Thanks,
> Slava.

