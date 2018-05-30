From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 14:08:01 +0200
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from
 core layer
In-Reply-To: <b8fa242d-c2d5-79fe-cab2-1c73adadbc4b@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-5-git-send-email-maxg@mellanox.com>
 <20180528072225.GE5618@lst.de>
 <b8fa242d-c2d5-79fe-cab2-1c73adadbc4b@mellanox.com>
Message-ID: <20180530120801.GA1817@lst.de>

On Wed, May 30, 2018@01:48:13PM +0300, Max Gurtovoy wrote:
> -       sig_attrs->check_mask =
> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
> -              (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD)
> +               sig_attrs->check_mask |= IB_SIG_CHECK_GUARD;
> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG)
> +               sig_attrs->check_mask |= IB_SIG_CHECK_APPTAG;
> +       if (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG)
> +               sig_attrs->check_mask |= IB_SIG_CHECK_REFTAG;
> +
>         return 0;
>  }
>
>
>
> I can reduce the instructions since we don't need to do a bitwise "or" with 
> 0 (check mask is set to 0 in the start of the function).

And it looks much cleaner to start with..
>
> Let me know if I can add your "Reviewed-by" for this.

Please keep it.
