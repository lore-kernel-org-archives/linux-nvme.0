Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7872EFAD3F0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 03:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIuT9pKU1FIOn3QKzaq8MPKLrS4YyBJdfK8D1GXP1Qs=; b=ekkDtCOj3hk2ek7+C8OAmtDvif
	71g7333gKzmyHd81TbHejQGDHlSDPEVicrO4DZIvezEbKnZocn1ojmOv/ti2rkT3opTSRUeMlcVBQ
	0Wr418kJoAY4KjFSj/3iyYlpOeCOOSGxGJbJPTXkKEP7dytH6OMqJvdefGjCsUOTkV+18357LoSmZ
	dMzEk/lbeycJLdlwIYq2uu/heAOaUtrLddPGYSa4JxTSka9X68qCw2M6TAe1meHS9sV3wYa6GLUCG
	RA5seLduNlVnskbKBJCqqc679IOvsML/B+ms2J2XIaG+C242uAtvJlzPBX2x5xHe5+OHXzQTRdo3H
	4hZvdEbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFkQr-0000000Awqq-2jRe;
	Thu, 23 Apr 2026 03:08:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFgj6-0000000Aoww-48t3
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 23:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776899484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIuT9pKU1FIOn3QKzaq8MPKLrS4YyBJdfK8D1GXP1Qs=;
	b=Q/A60bjWVTV/4+xxmAh2BvHZkrQsPKJwfooWdLUVEoDyboTyDZApndtFct2IR3HU0ZxIJo
	tmmau/yVgzfMcVAHDgvVF/q8OD+iVDvJaAkTgHdOXPA42Au7vbH1WFY+Faz+PjDmTpHF3a
	j6ppy5Vxw2xj11c+gOgfUd8A7ZUpwmI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-eTS3oLmANHGeSoNjNfHpAw-1; Wed,
 22 Apr 2026 19:11:20 -0400
X-MC-Unique: eTS3oLmANHGeSoNjNfHpAw-1
X-Mimecast-MFC-AGG-ID: eTS3oLmANHGeSoNjNfHpAw_1776899479
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A713C1800367;
	Wed, 22 Apr 2026 23:11:19 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.2.17.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9ECF119560AB;
	Wed, 22 Apr 2026 23:11:18 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: [RFC] example request-key helper script
Date: Wed, 22 Apr 2026 16:10:23 -0700
Message-ID: <20260422231043.2689681-3-cleech@redhat.com>
In-Reply-To: <20260422231043.2689681-1-cleech@redhat.com>
References: <20260422231043.2689681-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4iW-y8x1Y0DTYtmgs-iHL0VzoiGIRR-MaJd_DxZ_W1U_1776899479
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_161125_093682_CB0FDA00 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 22 Apr 2026 20:08:43 -0700
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

This is a prototype of a request-key helper to instantiate a "PSK request" key.

Assisted-by: Claude:claude-sonnet-4.5
---
#!/usr/bin/bash
#
# NVMe PSK Provider
#
# This script is called by /sbin/request-key when the kernel requests
# NVMe TLS PSKs via the nvme-psk-request key type.
#
# configure /etc/request-key.conf with an entry like the following:
# create  nvme-psk-request  *  *  /usr/libexec/nvme-psk-provider %k %d %c %S

KEY_ID=$1
DESCRIPTION=$2
CALLOUT_INFO=$3
KEYRING=$4

exec > >(logger -t "key.nvme-psk") 2>&1
echo "$0: $@"

# Parse callout info
eval $(echo "$CALLOUT_INFO" | tr ' ' '\n' | grep '=')

KEYFILE="/etc/nvme/tls-keys"
HOST_NQN=${hostnqn}
SUBSYS_NQN=${subnqn}

if [ -z "$KEYFILE" ] || [ -z "$HOST_NQN" ] || [ -z "$SUBSYS_NQN" ]; then
    echo "Error: Missing required parameters"
    keyctl negate "$KEY_ID" 1 "$KEYRING"
    exit 1
fi

if [ ! -f "$KEYFILE" ]; then
    echo "Error: Keyfile '$KEYFILE' not found"
    keyctl negate "$KEY_ID" 1 "$KEYRING"
    exit 1
fi

# Temporary file for binary payload
PAYLOAD_FILE=$(mktemp)
trap "rm -f $PAYLOAD_FILE" EXIT

KEY_COUNT=0

# Search for all matching entries in keyfile
while IFS= read -r line; do
    # Skip empty lines and comments
    [ -z "$line" ] && continue
    [[ "$line" =~ ^#.* ]] && continue

    # Extract the last space-separated field (the encoded key)
    encoded_key="${line##* }"
    # Extract everything before the last space (the description)
    description="${line% *}"

    # Parse description: NVMe<ver><type>0<hmac> <hostnqn> <subsysnqn> <digest>
    if [[ "$description" =~ ^NVMe([0-9])([RG])([0-9][0-9])[[:space:]]+([^[:space:]]+)[[:space:]]+([^[:space:]]+)[[:space:]]+([^[:space:]]+)$ ]]; then
        ver="${BASH_REMATCH[1]}"
        type="${BASH_REMATCH[2]}"
        hmac="${BASH_REMATCH[3]}"
        desc_hostnqn="${BASH_REMATCH[4]}"
        desc_subsysnqn="${BASH_REMATCH[5]}"
        desc_digest="${BASH_REMATCH[6]}"

        # Only process Retained keys (not Generated)
        if [ "$type" != "R" ]; then
            continue
        fi

        # Check if this matches our search criteria
        if [ "$desc_hostnqn" = "$HOST_NQN" ] && [ "$desc_subsysnqn" = "$SUBSYS_NQN" ]; then
            # Validate the encoded key format: NVMeTLSkey-1:xx:...:
            if [[ "$encoded_key" =~ ^NVMeTLSkey-1:([0-9][0-9]):(.+):$ ]]; then
                key_hmac="${BASH_REMATCH[1]}"
                base64_data="${BASH_REMATCH[2]}"

                echo "Found matching PSK: version=$ver type=$type hmac=$hmac"

                # Decode base64
                tmpfile=$(mktemp)
                echo -n "$base64_data" | base64 -d > "$tmpfile"
                decoded_len=$(stat -c%s "$tmpfile")

                if [ "$decoded_len" -lt 36 ]; then
                    echo "Warning: Decoded data too short ($decoded_len bytes), skipping"
                    rm -f "$tmpfile"
                    continue
                fi

                # Key length is decoded_len - 4 (CRC is last 4 bytes)
                key_len=$((decoded_len - 4))

                # Verify CRC32 (optional - nvme-cli already validated on import)
                # Extract key data (without CRC)
                key_data=$(dd if="$tmpfile" bs=1 count="$key_len" 2>/dev/null)

                # Decode digest from base64
                digest_data=$(echo -n "$desc_digest" | base64 -d)
                digest_len=$(echo -n "$digest_data" | wc -c)

                # Pack binary: hmac(1) + key_len(1) + digest_len(1) + key_data[key_len] + digest[digest_len]
                # Convert hmac from decimal string to hex byte
                printf "\\x$(printf '%02x' $key_hmac)" >> "$PAYLOAD_FILE"
                printf "\\x$(printf '%02x' $key_len)" >> "$PAYLOAD_FILE"
                printf "\\x$(printf '%02x' $digest_len)" >> "$PAYLOAD_FILE"
                echo -n "$key_data" >> "$PAYLOAD_FILE"
                echo -n "$digest_data" >> "$PAYLOAD_FILE"

                KEY_COUNT=$((KEY_COUNT + 1))
                rm -f "$tmpfile"
            else
                echo "Warning: Invalid encoded key format, skipping"
            fi
        fi
    fi
done < "$KEYFILE"

if [ "$KEY_COUNT" -eq 0 ]; then
    echo "Error: No matching keys found for host-nqn '$HOST_NQN' and subsystem-nqn '$SUBSYS_NQN'"
    keyctl negate "$KEY_ID" 1 "$KEYRING"
    exit 1
fi

# Instantiate the nvme-psk-request key with binary payload
echo keyctl instantiate "$KEY_ID" @s "$KEYRING" < "$PAYLOAD_FILE"
keyctl pinstantiate "$KEY_ID" "$KEYRING" < "$PAYLOAD_FILE"
if [ $? -eq 0 ]; then
    echo "Successfully instantiated $KEY_COUNT PSK(s)"
    exit 0
else
    echo "Error: Failed to instantiate request key"
    keyctl negate "$KEY_ID" 1 "$KEYRING"
    exit 1
fi


