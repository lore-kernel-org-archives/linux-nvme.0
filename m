From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Nov 2017 09:38:37 -0700
Subject: [PATCH 2/2] NVMe-CLI : WDC-Plugin Documentation for Updated
 Smart Log Command
In-Reply-To: <MWHPR04MB1025D9A09C89FF51CA5BAEACEA3A0@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <20171128142955.9747-1-jeff.lien@wdc.com>
 <20171128154724.GA11758@localhost.localdomain>
 <MWHPR04MB1025D9A09C89FF51CA5BAEACEA3A0@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20171129163836.GD24085@localhost.localdomain>

On Tue, Nov 28, 2017@04:24:05PM +0000, Jeffrey Lien wrote:
> Yea, I wasn't sure why the auto-generated files are included with the txt file vs just the txt file.  It seems to make more sense to push just the txt fail and then regenerate the other files, but that doesn't match what was done in the past.  

Push now, thanks.

I'd just recommend unstaging the .html and .1 files before committing,
and I'll generate the docs as needed. It's usually not a problem when
they're included in a pull request, but when conflicts in the generated
files happen, it's easier to fix by regenerating them than trying to
merge. The only reason we have them under source control is to not have
a dependency on asciidoc to install the program.
