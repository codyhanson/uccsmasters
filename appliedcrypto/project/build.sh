#! /bin/bash

latex hanson_proposal
latex hanson_proposal
bibtex hanson_proposal.aux
latex hanson_proposal
latex hanson_proposal
latex hanson_proposal
dvipdfm hanson_proposal.dvi

