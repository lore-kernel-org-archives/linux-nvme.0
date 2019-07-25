From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jul 2019 22:25:54 +0900
Subject: [PATCH] nvme-cli: update command message for "help"
In-Reply-To: <20190724171744.GA5568@localhost.localdomain>
References: <20190601055428.17906-1-minwoo.im.dev@gmail.com>
 <20190724171744.GA5568@localhost.localdomain>
Message-ID: <20190725132554.GA3018@minwoo-desktop>

On 19-07-24 11:17:45, Keith Busch wrote:
> On Sat, Jun 01, 2019@02:54:28PM +0900, Minwoo Im wrote:
> > The "help" subcommand will show the man page, not the help message which
> > is printed out to stdout by --help option.  The previous message might
> > make confusions between man page and --help options so that it needs to
> > be updated.
> 
> If you just type "nvme help", you get that help message. If you type
> "nvme help <command>", then you get that command's manpage. This
> behavior was copied from 'git'.

Hi Keith,

Yes, That's what I meant in this patch, but it does not look like cover
"nvme help" command itself.

Let's keep it that way, then.

Thanks!
