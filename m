From: pokorra@uni-siegen.de (Gerd Pokorra)
Date: Wed, 13 Feb 2019 12:28:01 +0100
Subject: KXG60ZNV256G not recognized
In-Reply-To: <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
References: <19873dbf-4c19-5cab-d5fb-c63f6cb72101@uni-siegen.de>
 <facf2124-d29c-2151-2419-db9b0776f3cd@suse.de>
 <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
 <ef3bbe97-8d3b-89bc-4149-60673b1da388@suse.de>
 <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
Message-ID: <1a626bba-4e02-426b-182e-2e863c6a5f77@uni-siegen.de>

Hello Johannes,

in the BIOS I see 'System Configuration' -> 'SATA Operation'

- Disabled

- AHCI

- RAID On


Currently it is set to 'RAID On'.

-- Gerd


Am 13.02.2019 um 12:06 schrieb Gerd Pokorra:
> Hello Johannes,
>
> the output of 'dmeg | grep -i nvm' shows that is remapped:
>
> [??? 4.403742] ahci 0000:00:17.0: Found 1 remapped NVMe devices.
>
> -- Gerd
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
