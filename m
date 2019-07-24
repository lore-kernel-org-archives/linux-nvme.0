From: kbusch@kernel.org (Keith Busch)
Date: Wed, 24 Jul 2019 11:17:45 -0600
Subject: [PATCH] nvme-cli: update command message for "help"
In-Reply-To: <20190601055428.17906-1-minwoo.im.dev@gmail.com>
References: <20190601055428.17906-1-minwoo.im.dev@gmail.com>
Message-ID: <20190724171744.GA5568@localhost.localdomain>

On Sat, Jun 01, 2019@02:54:28PM +0900, Minwoo Im wrote:
> The "help" subcommand will show the man page, not the help message which
> is printed out to stdout by --help option.  The previous message might
> make confusions between man page and --help options so that it needs to
> be updated.

If you just type "nvme help", you get that help message. If you type
"nvme help <command>", then you get that command's manpage. This
behavior was copied from 'git'.
