Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4A6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDm17YwFrBa0nAMI1QQ6pckfPJPB3FycCKEKG6+wEGY=; b=D6D3mqWO8Gf6erjjCihs1XPOYU
	+3DT1SxWLYwaA/rz7PRlKz97xbyBBydm8aV4tNLg4/frwVglVLz21NG8OES4Qvg0qHarfDJctOsBv
	k2YUUGhf/TJqcqAA507rRRsopLp66YoAEmhdbOQE7hXHUvxux3DmjuV56PoEdQyKjmBGqmodDQ81o
	3h3EShvQHF8fh1xQntHTsYfS3LOsj4OO4q5eZMIMZTp5dvWE+X1gzqGfSL9tjE6sQRByz7L8dD5GO
	JPQtMkL1S5F08Y3D6grDM5UuIupgLty8bjsK4cfEFrM0qoUNRiBUQksRSNYlrgtiWZcvQbnWPzNMO
	3m85d0vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCE6Q-006TN0-LV; Tue, 25 Jan 2022 05:10:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCE6N-006TMB-MT
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 05:10:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CF5E6B80DF6;
 Tue, 25 Jan 2022 05:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C3CC340E0;
 Tue, 25 Jan 2022 05:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643087440;
 bh=BEVe+YavO8Zvh19/8pYvNnZ7t8RCY/gLna1go7/ya14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bCrIjJQS7hpNgbkV+rEqW37A/jDyaOuhYRuE3KqX4NCEcl75D2235fbUzjjg4LN0D
 iZL/m2epkCPYw+JfZB+RiWgRe1kc/RC3Tw2LnUhSCN1hX63Rd43ZLeh9ric/ZL/Rml
 kznwICzXU62GNSs1CeJt91XZKO64DB8HmIGHtvgCh4aTVvxIOhz+jtpmGTCXTOTNOO
 EVoTkSHKMg55xTmaEWVQXpy/kuMIxR1dsUA9J2mlfcDzBX49nVv4uj37x3uaIbaGZB
 9nKV9OAHKRt0YxL9PUGw7470WHrmMo9XBFaZzuMtHLJw2I1FBNqhKeZ+r7imaSk4d8
 IMaLIFZ+84UaQ==
Date: Mon, 24 Jan 2022 21:10:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 3/7] lib: add rocksoft model crc64
Message-ID: <Ye+GTkrZ5YMe5qGt@sol.localdomain>
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <20220124160107.1683901-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124160107.1683901-4-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_211043_912892_14F35021 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon, Jan 24, 2022 at 08:01:03AM -0800, Keith Busch wrote:
> Since this model reflects inputs and outputs, a helper table and
> function are added to reverse bits of 8 and 64 bit values.

That's a silly way to do a bit-reflected CRC.  The proper way to do it is to
reflect the bytes too, so that the bits and bytes are ordered consistently, so
explicitly reflecting the bits isn't needed.  Most CRC-32's are bit-reflected,
and they are usually implemented this way.  E.g., see crc32_le() in lib/crc32.c.

Here's a Python script that shows that the Rocksoft CRC-64 can be computed
without explicitly reversing the bits.  It passes the tests from your patch 4:


COEFFS = [63, 61, 59, 58, 56, 55, 52, 49, 48, 47, 46, 44, 41, 37, 36, 34, 32,
          31, 28, 26, 23, 22, 19, 16, 13, 12, 10, 9, 6, 4, 3, 0]
POLY = sum(1 << (63 - coeff) for coeff in COEFFS)

# Generate the table.
table = [0] * 256
for i in range(256):
    crc = 0
    byte = i
    for j in range(8):
        if ((crc ^ (byte >> j)) & 1) == 1:
            crc = (crc >> 1) ^ POLY
        else:
            crc = crc >> 1
    table[i] = crc

# Compute the CRC-64 one byte at a time using the table.
def crc64_rocksoft(data):
    crc = 0xffffffffffffffff
    for byte in data:
        crc = (crc >> 8) ^ table[(crc & 0xff) ^ byte]
    return crc ^ 0xffffffffffffffff

# Tests
assert crc64_rocksoft(bytearray([0] * 4096)) == 0x6482D367EB22B64E
assert crc64_rocksoft(bytearray([255] * 4096)) == 0xC0DDBA7302ECA3AC
assert crc64_rocksoft(bytearray([i % 256 for i in range(4096)])) == 0x3E729F5F6750449C
assert crc64_rocksoft(bytearray([(255-i) % 256 for i in range(4096)])) == 0x9A2DF64B8E9E517E

# Print the table.
print(f'#define CRC64_ROCKSOFT_POLY 0x{POLY:016x}ULL')
print('')
print('static const u64 crc64_rocksoft_tab[] = {')
for i in range(0, 256, 2):
    print('\t', end='')
    for j in range(i, i + 2):
        print(f'0x{table[j]:016x}ULL,', end='')
        if j != 1:
            print(' ', end='')
    print('')
print('};')

