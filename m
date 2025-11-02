Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FC3CCF9F8
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Nov 2025 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ki39G4nK738bbMNvRVvZd2hgEp5hWfNTDjdCye7EBaM=; b=vHtPfsEUnxWfF5zLVNoe0HP/JE
	nkh4QqHKkacagVgUCZy1c+XvNdoHjXaP56/MHs52NEmLp6pLqFT+311p+FE4vKhkPKs3ZGLitu9d6
	2XaXhzmWMaqAubADi/wUEQjLh+6YR/RH69SNekmadLOt+K9YMZqGTR99nIL8zWYdKPDqIc8ffY475
	LDg95Sjj4TLqNE2umS5LHSUvNROj4WBsg3cOSz00MfSjXzzXWHmV+LG2nsdY1M/wdLmEIbVH+vMQ1
	AWjK2hrK8iaK/LB9JdYRte1b1a1lNlyzbXwBQi4k+hztVVOxFasNmLx4h01ngSbSyhu1+dvYSOeJL
	5f0VjcGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFObE-00000008G5t-4B5c;
	Sun, 02 Nov 2025 03:17:48 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFObC-00000008G5R-2pjd
	for linux-nvme@lists.infradead.org;
	Sun, 02 Nov 2025 03:17:47 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-294fe7c2e69so29182355ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 01 Nov 2025 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762053466; x=1762658266; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ki39G4nK738bbMNvRVvZd2hgEp5hWfNTDjdCye7EBaM=;
        b=XSKsessuaSutZaAV4wt0jrA0HCx0oAd357vy65Et+bEJ8ZUeDT3hNEf92ci/fnoRn1
         86CYdYR6gqfn2iJxiZw6UINnMFmkAfIJiq8ar5160XeJrEYAwpIYfaYKdRdai7tf/xCO
         ldE69JGV6v0Umd9g5Qcrrfyn/10rX8x+rjepO4eQPSMGWmMVIBjRYh63f726CfDxexRV
         UQVGmpAo+VRVU+gTF9cAZIGgg+j9w4amUQVl3p78Qhu1+uvrjkqm3K8rOmoX+j36GCve
         TBKGzLVEToOv1Ph79DxTUTII+nBnwoc38VwJmpc4WXSBzo+ZR/vQyU5ujx740kngGi7g
         Fq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762053466; x=1762658266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki39G4nK738bbMNvRVvZd2hgEp5hWfNTDjdCye7EBaM=;
        b=g4nRTTVY/y5ey5g4cQ0MxAkbAI74pm26znMSpq52JkxjoEJ0TM6jkN9Lo1xAGg0X2l
         eErOStLUOiSQei0K6QVT5SDun/KKHnvLclJ4OYhlgxj+JzLHF0X/Ev2RECTdeIZ1LrL9
         862vPRsmmEoFjO7D7xecoR+C70D+Dhfgh/Yc2A+a3uCW/1Egf9t+QKm/CanRF41K1J+1
         dNalPQBJeGPEcXCvRJvjv9rOBj6ZWbs1RfTdDvAMWuj/ig9ZVue5Vksl++oJ14I/+KaF
         pkp8zIhlbqaGfvAKXgXUw4z0IrAVcolBKbPfoMkVviQko/jHM7I5Vrgy6WtVeemtKu5L
         i+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjolFQ5CF+unuwgU6NeFehLkmp24ZMWJwxymepZzHviZN163xkQcHuspSN7swPuLnt6A68JzV78FdJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxz5/S47F/03bv33HnF9mPcIkxKvX14Rq0sORPQrNF6MqfaSPix
	vITFB4YNt8G7/ADC/oiKHEA0zy31bSJbYydP2xQ+LoKaky5d/3wpvvHR
X-Gm-Gg: ASbGncscgZybBP/68YpSA6ctdEyLNdFpsZj+cUF/fVUP3gEGK6ljR8PBRH0T+zDhySI
	HmD8CdYrDW8iwI+pI6dnlLithmjmIPYAj8qsVNM6nnwQaoymzQ8G5Jnwk4q6Vzm0T6oGmFl/y2t
	mtncCh4kYbKZqSIZiP9arFr3edZaqlGAWigHAFohC35uTky5ODIR21TwvbSygJ6oCkLzYpkO5eE
	qGJgZSSwJo6JNeZg0bJ/UCD9iP4+OpQfAAT/TRhmyMQwkAfUuAfInYZco4UUmjRRI0NYqtAVgsG
	2DRZD9mvCfF6gHyJwxGnxOy7+n/pKp+97Km74of72Fs9lIzcEjRwO+H2RaM4peMODMo/hv1wld9
	96ZuzX42wkFEsAspvtqMmztj4ZOcoGyFml5KhzcJ1L5YQp94fUuJNOYgQcYyhxDh9+iYFLMz5Ez
	mrGIfsK/y4voNYZzd1T8FDZLJFhi4vQCsi3ZjWRjwfyA2Vonw=
X-Google-Smtp-Source: AGHT+IHvnbsNY7Z1xfwDgRd9OeFl31anYCvkPi+0IlqF25O9nkiL9cTkNbN+APLDLKPpaGQTNJ3jkw==
X-Received: by 2002:a17:902:ce92:b0:295:2d76:72fe with SMTP id d9443c01a7336-2952d767409mr87303645ad.45.1762053465759;
        Sat, 01 Nov 2025 20:17:45 -0700 (PDT)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm70971055ad.105.2025.11.01.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 20:17:45 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: hare@suse.de,
	kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key() declaration
Date: Sat,  1 Nov 2025 20:17:42 -0700
Message-Id: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_201746_718794_54D5F468 
X-CRM114-Status: GOOD (  14.85  )
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

Fix build error when CONFIG_NVME_AUTH=m (module):

  drivers/nvme/common/auth.c:158:13: error: redefinition of
  'nvme_auth_extract_key'
  include/linux/nvme-auth.h:25:27: note: previous definition is here

The issue occurs because when NVME_AUTH is built as a module (=m), the
preprocessor symbol CONFIG_NVME_AUTH is not defined during compilation,
but the object file auth.o is still compiled as part of nvme-auth.ko.

With #ifdef CONFIG_NVME_AUTH, the header provides a static inline stub
when the config is =m, while auth.c provides the real implementation,
causing a redefinition conflict.

Use IS_REACHABLE(CONFIG_NVME_AUTH) instead of #ifdef CONFIG_NVME_AUTH to
properly handle both built-in (=y) and modular (=m) builds. IS_REACHABLE
evaluates to true when the code is reachable, either because it's built-in
or because we're building the same module.

Fixes: e30cd923b3ed ("nvme-auth: switch to use 'struct key'")
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
Hi,

Please review this very carefully :-

Broken scenario with #ifdef CONFIG_NVME_AUTH:

make menuconfig -->  NVMe over Fabrics In-Band Authentication --> * 

nvme (nvme-6.19) # grep NVME_AUTH .config
CONFIG_NVME_AUTH_STATE=y
CONFIG_NVME_AUTH=m
nvme (nvme-6.19) #

1: Makefile compiles auth.c
  obj-$(CONFIG_NVME_AUTH) += nvme-auth.o
  nvme-auth-y += auth.o
  auth.c gets compiled as part of nvme-auth.ko module
  make[1]: Entering directory '/mnt/data/nvme/drivers/nvme'
  CC [M]  common/auth.o
  CC [M]  host/core.o
  CC [M]  host/sysfs.o
  CC [M]  target/configfs.o
  CC [M]  host/auth.o
  CC [M]  host/fabrics.o
  CC [M]  target/fabrics-cmd-auth.o
  CC [M]  target/auth.o
common/auth.c:158:13: error: redefinition of ‘nvme_auth_extract_key’
  158 | struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
      |             ^~~~~~~~~~~~~~~~~~~~~

2: Preprocessor evaluates header guards in nvme-auth.h

#ifdef CONFIG_NVME_AUTH <---- CONFIG_NVME_AUTH is NOT defined when =m
                                 Only CONFIG_NVME_AUTH_MODULE is defined!
  struct key *nvme_auth_extract_key(...); <---  Declaration (NOT reached)
#else
static inline struct key *nvme_auth_extract_key(...) { <---- This is used  Static inline stub
      return ERR_PTR(-ENOKEY);                           
  }
  #endif

3: Compiler sees BOTH definitions when NVME_AUTH is enabled
   using make menuconfig  NVMe over Fabrics In-Band Authentication = * 
  - auth.c:158 has the real implementation: struct key *nvme_auth_extract_key(...)
  - Header provides static inline stub: static inline struct key *nvme_auth_extract_key(...)

---
 include/linux/nvme-auth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index afc84a4cd94a..49a8afc16028 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -18,7 +18,7 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
-#ifdef CONFIG_NVME_AUTH
+#if IS_REACHABLE(CONFIG_NVME_AUTH)
 struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
 				  size_t secret_len, bool *generated);
 #else
-- 
2.40.0


