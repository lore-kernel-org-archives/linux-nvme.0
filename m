From: hare@suse.com (Hannes Reinecke)
Date: Sat, 6 Oct 2018 15:09:20 +0200
Subject: [PATCH] nvmetcli: ANA configuration support
In-Reply-To: <20181006124353.GA8324@lst.de>
References: <20180727110859.4212-1-hare@suse.de> <20181006124353.GA8324@lst.de>
Message-ID: <570f1c05-1995-0eb9-7649-16aa0204e783@suse.com>

On 10/6/18 2:43 PM, Christoph Hellwig wrote:
> I just wanted to apply this in preparation of a new nvmetcli release
> once Linux 4.19 is released with ANA support, but the code does not
> seem to work well on kernel without multipath support.  E.g.:
> 
> Traceback (most recent call last):
>   File "./nvmetcli", line 735, in <module>
>     main()
>   File "./nvmetcli", line 717, in main
>     funcs[sys.argv[1]](savefile)
>   File "./nvmetcli", line 684, in clear
>     nvme.Root().clear_existing()
>   File "/root/nvmetcli/nvmet/nvme.py", line 315, in clear_existing
>     p.delete()
>   File "/root/nvmetcli/nvmet/nvme.py", line 676, in delete
>     a.delete()
>   File "/root/nvmetcli/nvmet/nvme.py", line 200, in delete
>     os.rmdir(self.path)
> PermissionError: [Errno 1] Operation not permitted: '/sys/kernel/config/nvmet/ports/2/ana_groups/1'
> 
> The new ANA code will probably need similar exception handling as the
> inline_data_size attribute.
> 
Okay, will be fixing it up.

Cheers,

Hannes
