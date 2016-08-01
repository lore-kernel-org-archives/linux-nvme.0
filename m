From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 04:23:54 -0700
Subject: [PATCH] nvmetcli: More refined cleanup of README
In-Reply-To: <1469727426-1178-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1469727426-1178-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20160801112354.GE28246@infradead.org>

On Thu, Jul 28, 2016@10:37:06AM -0700, Jay Freyensee wrote:
> --- a/README
> +++ b/README
> @@ -12,6 +12,11 @@ https://github.com/agrover/configshell-fb first.
>  nvmetcli can be run directly from the source directory or installed
>  using setup.py.
>  
> +If you choose to use the provided exe 'nvmetcli', you can move
> +'nvmetcli' to /usr/sbin and the file 'nvmet.service' to
> +/lib/systemd/system for global management of NVMe target setups
> +for the machine.

Hmm.  Maybe we'll need to add a install rule to setup.py instead?
Either way the preferred way to install nvmetcli is to use the deb
or rpm packaging created by make deb or make rpm.  The documentation
should point to those as the first choice.

>  Common Package Dependencies and Problems
>  -----------------------------------------
>  nvmetcli uses the 'python-six' and 'pyparsing' packages
> @@ -53,6 +58,13 @@ The following walks through an example using interactive mode.
>  ...> create hostnqn
>  
>  #
> +# remove access of a subsystem by deleting the Host NQN
> +#
> +
> +...> cd /subsystems/testnqn/allowed_hosts/
> +...> delete hostnqn
> +
> +#
>  # Alternatively this allows any host to connect to the subsystsem.  Only
>  # use this in tightly controller environments:
>  #
> @@ -65,7 +77,7 @@ The following walks through an example using interactive mode.
>  # unused one will be used.
>  #
>  
> -...> cd namespaces
> +...> cd /subsystems/testnqn/namespaces
>  ...> create 1
>  ...> cd 1
>  ...> set device path=/dev/nvme0n1

But I've applied this part already and pushed it out.
